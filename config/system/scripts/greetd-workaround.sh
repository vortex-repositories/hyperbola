#!/bin/bash

## Due to issues post-build when rebasing from a different image, this is done via a custom service.
grep -E '^greetd:' /usr/etc/passwd | tee -a /etc/passwd
grep -E '^greetd:' /usr/etc/group | tee -a /etc/group
grep -E '^greetd:' /usr/etc/shadow | tee -a /etc/shadow

# this is simply a workaround fix script that fixes issues where greetd doesnt exist despite being installed in build process.
