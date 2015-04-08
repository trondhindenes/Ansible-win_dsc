# Ansible-win_dsc
Native DSC module for Ansible.

Requires the WMF5 preview February 2015 version of PowerShell installed on the managed node (http://blogs.msdn.com/b/powershell/archive/2015/02/18/windows-management-framework-5-0-preview-february-2015-is-now-available.aspx)

Before using the win_dsc5 module, use the win_lcm5 module to set refresh mode to "Disabled" on the managed node.

Also, make sure the required DSC resources exist on the managed node. 
