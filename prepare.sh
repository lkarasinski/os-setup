pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm
pacman -S --noconfirm reflector
reflector --latest 200 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
