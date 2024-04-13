BRANCH=${1:-main}
curl -Ls "https://raw.githubusercontent.com/lkarasinski/os-setup/$BRANCH/prepare-arch.sh" | sh

# Make sure there is no /tmp/os-setup directory
sudo rm -rf /tmp/os-setup

git clone -b "$BRANCH" https://github.com/lkarasinski/os-setup /tmp/os-setup
ansible-playbook /tmp/os-setup/setup-user.yml

sudo -u lkarasinski -H sh -c "ansible-galaxy install -r /tmp/os-setup/requirements.yml"
sudo -u lkarasinski -H sh -c "ansible-playbook /tmp/os-setup/arch-playbook.yml --ask-vault-pass"
