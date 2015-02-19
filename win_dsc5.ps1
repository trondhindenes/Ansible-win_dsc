#!powershell
# (c) 2015, Trond Hindenes <trond@hindenes.com>, and others
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;
$result = New-Object psobject;
Set-Attr $result "changed" $false;

$resourcename = Get-Attr -obj $params -name resource_name -failifempty $true -resultobj $result

$Attributes = $params | get-member | where {$_.MemberTYpe -eq "noteproperty"} | where {$_.Name -ne "resource_name"} | select -ExpandProperty Name


if (!($Attributes))
{
    Fail-Json -obj $result -message "No attributes specified"
}

#Always return the name
set-attr -obj $result -name "resource_name" -value $resourcename
set-attr -obj $result -name "Attributes" -value $Attributes

$Attrib = @{}

<#
$params.Keys | foreach-object {
    $Attrib.Add($_,$params.Item($_))
    set-attr -obj $result -name $_ -value $params.Item($_)
    }
#>

$Keys = $params.psobject.Properties | where {$_.MemberTYpe -eq "Noteproperty"} | where {$_.Name -ne "resource_name"} | select -ExpandProperty Name
foreach ($key in $keys)
{
    $Attrib.add($key, ($params.$key))
    set-attr -obj $result -name $key -value ($params.$key)
}

$Config = @{
   Name = ($resourcename)
   Property = @{
        }
    }


$Resource = Get-DscResource -Name $resourcename -ErrorAction SilentlyContinue
if (!$Resource)
{
    Fail-Json -obj $result -message "Resource $resourcename not found"
}

#Convert params to correct datatype and inject
#Convert params to correct datatype and inject
$attrib.Keys | foreach-object {
    $Key = $_.replace("item_name", "name")
    $prop = $resource.Properties | where {$_.Name -eq $key}
    if (!$prop)
    {
        Fail-Json -obj $result -message "Property $key in resource $resourcename is not a valid property"
    }
    ElseIf ($prop.PropertyType -eq "[string]")
    {
        [String]$KeyValue = $attrib.Item($_)
    }
    ElseIf ($prop.PropertyType -eq "[bool]")
    {
        if ($attrib.Item($_) -like "true")
        {
            [bool]$KeyValue = $true
        }
        ElseIf ($attrib.Item($_) -like "false")
        {
            [bool]$KeyValue = $false
        }
    }
    ElseIf ($prop.PropertyType -eq "[int]")
    {
        [int]$KeyValue = $attrib.Item($_)
    }

    $config.Property.Add($key,$KeyValue)
    }


try
{
    
    $TestResult = Invoke-DscResource @Config -Method Test -ErrorVariable TestError -ErrorAction SilentlyContinue
    if (!($TestResult))
    {
       throw ($TestError[0].Exception.Message)
    }
    ElseIf (($testResult.InDesiredState) -ne $true) 
    {
        Invoke-DscResource -Method Set @Config
        Set-Attr $result "changed" $true
    }

}
Catch
{
    Fail-Json -obj $result -message $_[0].Exception.Message
}


#set-attr -obj $result -name "property" -value $property
Exit-Json -obj $result



