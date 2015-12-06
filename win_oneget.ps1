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

#Temporary fix
Set-StrictMode -Off

$params = Parse-Args $args;
$result = New-Object psobject;
Set-Attr $result "changed" $false;


$PackageName = Get-Attr -obj $params -name name -failifempty $true -resultobj $result
$Force = Get-Attr -obj $params -name force
$Ensure = Get-Attr -obj $params -name Ensure
$Source = Get-Attr -obj $params -name source
if (!($force)) {$force = $false}
if (!($Ensure)) {$Ensure = "Present"}

$HasFails = $false


$Packages = $Packagename.Split(",")
foreach ($package in $packages)
{
    $package = get-package -name $PackageName -errorAction silentlyContinue
    if ((!$Package) -and ($ensure -eq "Present"))
    {
        if ($Source)
        {
          $FindPackage = find-package -name $packagename -source $Source -errorAction SilentlyContinue -ForceBootstrap
        }
        else
        {
          $FindPackage = find-package -name $packagename -errorAction SilentlyContinue -ForceBootstrap
        }

        if (!($FindPackage))
        {
            Fail-Json -obj $result -message "Could not find package $package"
        }

        if ($Source) {
          Install-Package $PackageName -Source $Source -ForceBootstrap -Force
        }
        else
        {
          Install-Package $PackageName -ForceBootstrap -Force
        }

        Set-Attr $result "changed" $true;
    
    }


}

Exit-Json -obj $result
