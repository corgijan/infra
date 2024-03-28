#!/bin/bash
ansible-playbook -i inventory-local.yml flatpak-playbook.yml --ask-become-pass
