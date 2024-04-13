BRANCH=${1:-main}
curl -Ls "https://raw.githubusercontent.com/lkarasinski/arch-playbook/$BRANCH/prepare-arch.sh" | sh

# Make sure there is no /tmp/arch-playbook directory
sudo rm -rf /tmp/arch-playbook

git clone -b "$BRANCH" https://github.com/lkarasinski/arch-playbook /tmp/arch-playbook
ansible-playbook /tmp/arch-playbook/setup-user.yml

sudo -u lkarasinski -H sh -c "ansible-galaxy collection install community.general"
sudo -u lkarasinski -H sh -c "ansible-galaxy role install jahrik.yay"
sudo -u lkarasinski -H sh -c "ansible-galaxy collection install ansible.posix"
sudo -u lkarasinski -H sh -c "ansible-galaxy collection install kewlfft.aur"

sudo -u lkarasinski -H sh -c "ansible-playbook /tmp/arch-playbook/arch-playbook.yml --ask-vault-pass"

