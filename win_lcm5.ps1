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


$RefreshMode = Get-Attr -obj $params -name refresh_mode -failifempty $true -resultobj $result

If (($RefreshMode -ne 'Disabled') -and ($RefreshMode -ne 'Push') -and ($RefreshMode -ne 'Pull')) {
    Fail-Json $result "refresh_mode is '$RefreshMode'; must be 'Push', 'Pull' or 'Disabled'"
}

$CurrentRefreshMode = Get-DscLocalConfigurationManager | select -ExpandProperty Refreshmode

if ($CurrentRefreshMode -eq $RefreshMode)
{
    #our work here is done
    Exit-Json -obj $result
}
Else
{

    [DscLocalConfigurationManager()]
    Configuration Meta {
           Settings {
               RefreshMode = $RefreshMode
           }
    }
    try
    {
        meta
        Set-DscLocalConfigurationManager -Path .\Meta  -ErrorAction Stop -ErrorVariable lcmerror
    
    }
    Catch
    {
    }
    
}

#Reread the setting
$CurrentRefreshMode = Get-DscLocalConfigurationManager | select -ExpandProperty Refreshmode

if ($CurrentRefreshMode -eq $RefreshMode)
{
    #our work here is done
    Set-Attr $result "changed" $true;
    set-attr -obj $result -name "refresh_mode" -value $RefreshMode
    Exit-Json -obj $result
}

