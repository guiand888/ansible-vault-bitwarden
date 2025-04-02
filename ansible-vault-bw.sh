#!/bin/bash

# Use a session token to unlock your Bitwarden Vault shell-wide.
# export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+' | head -n 1)

# Default Bitwarden secret
BW_DEFAULT_PASS_ENTRY="ansible-vault-main"

# Check if a variable for the Bitwarden secret was provided via environment
check_env_var(){
    if [ -n "$BW_PASS_NAME" ]; then
        BW_PASS_ENTRY="$BW_PASS_NAME"
    else
        BW_PASS_ENTRY="$BW_DEFAULT_PASS_ENTRY"
    fi
}

# Check Bitwarden status
bw_status_parsing() {
    bw_status=$(bw status --session="$BW_SESSION" | jq -r '.status')
}

# Check Bitwarden Vault status locked/unlocked and echo $BW_DEFAULT_PASS_ENTRY
bw_status_check_default() {
    if [ "$bw_status" = "locked" ]; then
        exit
    elif [ "$bw_status" = "unlocked" ]; then
        bw get password "$BW_PASS_ENTRY" --session="$BW_SESSION"
    else
        exit
    fi
}

# Run
check_env_var "$1"  # Pass the first argument to the function
bw_status_parsing
bw_status_check_default
