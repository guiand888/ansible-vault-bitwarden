X
===

## Install Bitwarden CLI
Link: [Bitwarden Documentation](https://bitwarden.com/help/cli/)

In summary:
1. Download the `bw` native executable.
2. `chmod +x` it.
3. Move it someplace suitable in your $PATH; on Feora, I put it under `$HOME/.local/bin`.
4. Login using `bw login`

## Install the shell script
```bash
wget -P $HOME/.local/bin https://raw.githubusercontent.com/guiand888/ansible-vault-bitwarden/main/ansible-vault-bw.sh && chmod +x $HOME/.local/bin/ansible-vault-bw.sh
```

## Setup shell aliases (optionnal)
This is purely for convenience, but nonethelss helps a lot.

Add to your `.bashrc` or `.zshrc`:
```bash
# Bitwarden Vault Unlock alias
bw-unlock() {
    export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+' | head -n 1)
}

# Ansible Vault with Bitwarden alias
ansible-vault-bw() {
    ansible-vault "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}
```

## Run it!
