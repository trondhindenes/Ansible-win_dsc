#!/usr/bin/python
# -*- coding: utf-8 -*-

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

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: win_oneget_source
version_added: "1.9"
short_description: Add a package source to the OneGet package manager
description:
     
options:
  name:
    description:
      - The desired package source name
    required: true
    default: null
    aliases: []
  provider:
    description:
      - The provider name for the new package source
    required: true
    default: null
    aliases: []
  location:
    description:
      - The location of the new package source
    required: true
    default: null
    aliases: []
author: Tal Auslander
'''

EXAMPLES = '''
# Playbook example
  - name: Add cloudshare-staging package source
    win_oneget_source:
      name: "aspnetrelease"
      provider: "NuGet"
      location: "https://www.myget.org/F/aspnetrelease"
'''
