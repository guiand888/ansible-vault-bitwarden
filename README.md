Ansible Vault password input with Bitwarden CLI
===

Simple `bash` script facilitating the use of Bitwarden CLI to key-in `ansible-vault` passwords.

Easily rids of multiple drawbacks of `ansible-vault`:
- Repetitive password prompts
- Passwords *hanging around your filesystem* in plaintext vault password files
- Editing vault-encrypted files - for instance, directly in VS Code - "on the fly", without password prompt and without decrypting them

![ansible-vault-bw-demo](ansible-vault-bw-demo.gif)

## Prerequisites:
- `ansible` and `ansible-vault`
- A Bitwarden account with your `ansible-vault` password saved as `ansible-vault-main`
  - The ansible-vault secret needs to saved as the "Login" type, in the "password" field.
  - The script also supports feeding any specific BW entry as a vault secret with the `--bw-entry` argument
- That's it!

## Steps:
### 1. Install Bitwarden CLI
Link: [Bitwarden Documentation](https://bitwarden.com/help/cli/)

In summary:
1. Download the `bw` native executable.
2. `chmod +x` it.
3. Move it someplace suitable in your $PATH; on Feora, I put it under `$HOME/.local/bin`.
4. Login using `bw login`

### 2. Install the shell script
```bash
wget -P $HOME/.local/bin https://raw.githubusercontent.com/guiand888/ansible-vault-bitwarden/main/ansible-vault-bw.sh && chmod +x $HOME/.local/bin/ansible-vault-bw.sh
```

### 3. Setup shell aliases (optionnal)
This is purely for convenience, but nonethelss helps a lot.  
Add shell aliases to your `.bashrc` or `.zshrc`: [templates](https://github.com/guiand888/ansible-vault-bitwarden).

## Run it!
### CLI
1. Unlock your Bitwarden password vault and set the required `$BW_SESSION` variable:
    > `bw-unlock`
2. Run `ansible-vault-bw` or `ansible-playbook-bw` in place of the standard command.
3. If you want to point to a specific Bitwarden entry:
    > `ansible-vault-bw --bw-entry my_secret_name` 

Demo:

1. Unlock you Bitwarden vault: `bw-unlock`.
2. Encrypt a secret: `echo "top secret" > my_secret_file.txt && ansible-vault-bw encrypt ./my_secret_file.txt`
3. Read an existing secret: `ansible-vault-bw ./my_secret_file.txt`

### VS Code
You can also edit encrypted files directly in VS Code, without password prompt or having to decrypt them first.  
This limits the risk of accidentally commiting secrets in plain text to source control.

In the integrated terminal , run...  
```bash
EDITOR='code --wait'
ansible-vault decrypt ./my_secret_file.txt
```
And your file will open in plaintext, but save in its encrypted form once you close it.

## To do:
- [x] Add check for vault status locked/unlocked
- [x] Add support for multiple `ansible-vault` secrets
- [ ] Shell completion
