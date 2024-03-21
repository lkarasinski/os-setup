pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm
pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
