pacman-key --init
pacman-key --populate archlinux
pacman -Sy --needed --noconfirm archlinux-keyring && pacman --noconfirm -Su
pacman -Syu --noconfirm
pacman -S --noconfirm reflector
# Temporarily skip reflector, because it takes too long to run. Will enable when the config is ready.
# reflector --latest 200 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
pacman -S --noconfirm ansible-core git
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
git clone https://github.com/lkarasinski/arch-playbook /tmp/arch-playbook
ansible-playbook /tmp/arch-playbook/arch-playbook.yml --ask-vault-pass
