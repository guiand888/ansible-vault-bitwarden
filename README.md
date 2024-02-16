# Install Bitwarden CLI
Link: [Bitwarden Documentation](https://bitwarden.com/help/cli/)

In summary:
1. Download the `bw` native executable.
2. `chmod +x` it.
3. Move it someplace suitable in your $PATH; on Feora, I put it under `$HOME/.local/bin`.
4. Login using `bw login`


# Setup shell aliases
This is purely for convenience. Add to your `.bashrc` or `.zshrc`:
```bash
bw-unlock() {
    export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION=\"\K[^\"]+')
}
ansible_vault_wrapper() {
  cmd=(ansible-vault "--vault-password-file=./bitwarden_ansible_vault_unlock.sh" "$@")
  "${cmd[@]}"
}
