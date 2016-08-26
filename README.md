# Ansible-win_dsc
Native DSC module for Ansible.

## Windows System Prerequisites
 - PowerShell 5.0, which is included in [Windows Management Framework 5.0][https://www.microsoft.com/en-us/download/details.aspx?id=50395] need to be installed on managed nodes.

You can read more about Windows Management Framework 5.0 [here](https://msdn.microsoft.com/en-us/powershell/wmf/releasenotes).  

Before using the win_dsc5 module, use the win_lcm5 module to set refresh mode to "Disabled" on the managed node.

Also, make sure the required DSC resources exist on the managed node.

You should also check out a few other repos related to DSC and Ansible:
https://github.com/trondhindenes/AnsibleDscModuleGenerator

https://github.com/trondhindenes/Ansible-Auto-Generated-Modules/tree/master
