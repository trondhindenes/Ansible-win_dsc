#!powershell
# (c) 2015, Tal Auslander <tal@cloudshare.com>, and others
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

$Name = Get-Attr -obj $params -name name -failifempty $true -resultobj $result
$Provider = Get-Attr -obj $params -name provider -failifempty $true -resultobj $result
$Location = Get-Attr -obj $params -name location -failifempty $true -resultobj $result

$packageSource = Get-PackageSource $Name -errorAction silentlyContinue

if ($packageSource -And (($packageSource.Provider.Name -ne $Provider) -Or ($packageSource.Location -cne $Location))) {
  Unregister-PackageSource $Name
  $packageSource = $false
}

if (!$packageSource)
{
  Register-PackageSource -Name $Name -Provider $Provider -Trusted -Location $Location
  Set-Attr $result "changed" $true;
}

Exit-Json -obj $result
