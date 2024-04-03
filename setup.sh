curl -Ls https://raw.githubusercontent.com/lkarasinski/arch-playbook/main/prepare-arch.sh | sh

git clone https://github.com/lkarasinski/arch-playbook /tmp/arch-playbook
ansible-playbook /tmp/arch-playbook/setup-user.yml

sudo -u lkarasinski -H sh -c "ansible-galaxy collection install community.general"
sudo -u lkarasinski -H sh -c "ansible-galaxy role install jahrik.yay"
sudo -u lkarasinski -H sh -c "ansible-galaxy collection install ansible.posix"
sudo -u lkarasinski -H sh -c "ansible-galaxy collection install kewlfft.aur"

sudo -u lkarasinski -H sh -c "ansible-playbook /tmp/arch-playbook/arch-playbook.yml --ask-vault-pass"

