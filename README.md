Ansible Vault password input with Bitwarden CLI
===

Simple `bash` script facilitating the use of Bitwarden CLI to key-in `ansible-vault` passwords.

Easily rids of 2 drawbacks of `ansible-vault`:
- Repetitive password prompts
- Plaintext password hanging around in password files

![ansible-vault-bw-demo](ansible-vault-bw-demo.gif)

# Prerequisites:
- `ansible` and `ansible-vault`
- A Bitwarden account with your `ansible-vault` password saved as `ansible-vault-main`
  - Script also supports multiple passwords if passed as first argument $1
- That's it!

# Steps:
## 1. Install Bitwarden CLI
Link: [Bitwarden Documentation](https://bitwarden.com/help/cli/)

In summary:
1. Download the `bw` native executable.
2. `chmod +x` it.
3. Move it someplace suitable in your $PATH; on Feora, I put it under `$HOME/.local/bin`.
4. Login using `bw login`

## 2. Install the shell script
```bash
wget -P $HOME/.local/bin https://raw.githubusercontent.com/guiand888/ansible-vault-bitwarden/main/ansible-vault-bw.sh && chmod +x $HOME/.local/bin/ansible-vault-bw.sh
```

## 3. Setup shell aliases (optionnal)
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

# Ansible Playbook with Bitwarden alias
ansible-playbook-bw() {
    ansible-playbook "$@" --vault-password-file="$HOME/.local/bin/ansible-vault-bw.sh"
}
```

# Run it!
1. Unlock your Bitwarden password vault and set the required `$BW_SESSION` variable:
  > `bw-unlock`
2. Run `ansible-vault-bw` or `ansible-playbook-bw` in place of the standard command. 

Demo:

1. Unlock you Bitwarden vault: `bw-unlock`.
2. Encrypt a secret: `echo "top secret" > my_secret.txt && ansible-vault-bw encrypt ./my_secret.txt`
3. Read an existing secret: `ansible-vault-bw ./my-secret.txt`

# To do:
- [ ] Add support for multiple `ansible-vault` secrets in shell config
- [ ] Add check for vault status locked/unlocked in shell config