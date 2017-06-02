# NOT MAINTAINED!!!

win_dsc has been merged to ansible core, so please do not submit issues/pull requests against this repo. Please update your playbooks to use win_dsc from Ansible core.

# Ansible-win_dsc
Native DSC module for Ansible.

PowerShell 5.0, which is included in [Windows Management Framework 5.0][https://www.microsoft.com/en-us/download/details.aspx?id=50395] need to be installed on managed nodes. You can read more about Windows Management Framework 5.0 [here](https://msdn.microsoft.com/en-us/powershell/wmf/releasenotes).  

Before using the win_dsc5 module, use the win_lcm5 module to set refresh mode to "Disabled" on the managed node.

Also, make sure the required DSC resources exist on the managed node.

### If the DSC Resource need a Credential Object as Parameter do as follow:
```
Parametername_username
Parametername_password
```

#### Example xADDomain
```
   - name: Installing Domain
     win_dsc5:
       resource_name: "xADDomain"
       DomainName: "{{ads_domain_name}}"
       DomainAdministratorCredential_username: "Administrator"
       DomainAdministratorCredential_password: "{{ads_administrator_password}}"
       SafemodeAdministratorPassword_username: "Administrator"
       SafemodeAdministratorPassword_password: "{{ads_administrator_password}}"
```

### If the DSC Resource need a String Array as Parameter do as follow:
```
Parametername: "string1,string2"
```
The commaseperated string will get split and a Powershell String Array will get Attached to the Property.

#### Example xSmbShare
```
   - name: Create Share
      win_dsc5:
        resource_name: "xSmbShare"
        Ensure: "Present"
        item_name: "MyShare"
        Path: "C:\\Data\\MyShare"
        Description: "This will be my Share"
        ReadAccess: "Domain Users"
        ChangeAccess: "User1,User2"
        FullAccess: "Domain Admins"
```

You should also check out a few other repos related to DSC and Ansible:
https://github.com/trondhindenes/AnsibleDscModuleGenerator

https://github.com/trondhindenes/Ansible-Auto-Generated-Modules/tree/master
