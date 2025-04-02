# Bitwarden Vault Unlock alias
bw-unlock() {
    export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+' | head -n 1)
}

# Ansible Vault with Bitwarden alias
ansible-vault-bw() {
    ansible-vault "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}

# Ansible Playbook with Bitwarden alias
ansible-playbook-bw() {
    ansible-playbook "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}
