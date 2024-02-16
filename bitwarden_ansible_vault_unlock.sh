#!/bin/bash

# Use a session token to unlock your Bitwarden Vault shell-wide.
# export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+')

# Default Bitwarden secret
BW_DEFAULT_PASS_ENTRY="ansible-vault-main"

# Check if a variable for the Bitwarden secret was provided at runtime
check_runtime_var(){
    if [ "$#" -eq 0 ]; then
       BW_PASS_ENTRY="$BW_DEFAULT_PASS_ENTRY"
    else
       BW_PASS_ENTRY=$1
    fi
}

# Check Bitwarden status
bw_status_parsing() {
    bw_status=$(bw status --session "$BW_SESSION" | jq -r '.status')
}

# Check Bitwarden Vault status locked/unlocked and echo $BW_DEFAULT_PASS_ENTRY
bw_status_check_default() {
    if [ "$bw_status" = "locked" ]; then
        echo 'Bitwarden vault is locked.'
        echo 'Exiting.'
        exit
    elif [ "$bw_status" = "unlocked" ]; then
        bw get password "$BW_PASS_ENTRY"
    else
        echo "Status unknown. Exiting."
        exit
    fi
}

# Run
check_runtime_var
bw_status_parsing
bw_status_check_default
