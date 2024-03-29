#!/bin/bash
ansible-playbook -i inventory-local.yml playbooks/* --ask-become-pass
