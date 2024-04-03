#!/bin/bash
pacman-key --init
pacman-key --populate archlinux
pacman -Sy --needed --noconfirm archlinux-keyring && pacman --noconfirm -Su
pacman -Syu --noconfirm

pacman -S --noconfirm ansible-core git sudo reflector

# Temporarily skip reflector, because it takes too long to run. Will enable when the config is ready.
# reflector --latest 200 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist

# Install collection required to create sudo user
ansible-galaxy collection install community.general
