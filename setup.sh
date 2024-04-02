pacman-key --init
pacman-key --populate archlinux
pacman -Sy --needed --noconfirm archlinux-keyring && pacman --noconfirm -Su
pacman -Syu --noconfirm
pacman -S --noconfirm reflector
# Temporarily skip reflector, because it takes too long to run. Will enable when the config is ready.
# reflector --latest 200 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --noconfirm ansible-core git
ansible-galaxy collection install community.general
ansible-galaxy role install jahrik.yay
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install kewlfft.aur
git clone https://github.com/lkarasinski/arch-playbook /tmp/arch-playbook
ansible-playbook /tmp/arch-playbook/arch-playbook.yml --ask-vault-pass
