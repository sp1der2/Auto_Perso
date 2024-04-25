#!/bin/bash

ssh-copy-id sp1der@10.52.196.5
ansible-playbook -i inventory.ini pc_perso.yaml --user=sp1der --ask-become-pass
