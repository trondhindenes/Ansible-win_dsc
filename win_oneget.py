#!/usr/bin/python
# -*- coding: utf-8 -*-

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

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: win_oneget
version_added: "1.8"
short_description: Install packages using the OneGet package manager
description:
     
options:
  refresh_mode:
    description:
      - The desired refresh mode. Valid options are "Disabled", "Push", "Pull"
    required: true
    default: null
    aliases: []

author: Trond Hindenes
'''

EXAMPLES = '''
# Playbook example
  - name: Install Chocolatey
    win_oneget:
      name: "Chocolatey"
'''

