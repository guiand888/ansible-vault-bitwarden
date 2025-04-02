# Bitwarden Vault Unlock alias
bw-unlock() {
    export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+' | head -n 1)
}

# Ansible Vault with Bitwarden alias
ansible-vault-bw() {
    if [ "$1" = "--bw-entry" ]; then
        export BW_PASS_NAME="$2"
        shift 2  # Remove these two arguments
    else
        unset BW_PASS_NAME  # Use default if no --bw-entry specified
    fi
    ansible-vault "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}

# Ansible Playbook with Bitwarden alias
ansible-playbook-bw() {
    if [ "$1" = "--bw-entry" ]; then
        export BW_PASS_NAME="$2"
        shift 2  # Remove these two arguments
    else
        unset BW_PASS_NAME  # Use default if no --bw-entry specified
    fi
    ansible-playbook "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}

