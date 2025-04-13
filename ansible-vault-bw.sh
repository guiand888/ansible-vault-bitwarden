#!/bin/bash

# Use a session token to unlock your Bitwarden Vault shell-wide.
# export BW_SESSION=$(bw unlock | grep -oP 'BW_SESSION="\K[^"]+' | head -n 1)

# Bitwarden entry name precedence:
# 1. Command line argument BW_PASS_NAME
# 2. Environment variable BW_PASS_NAME
# 3. Default value BW_DEFAULT_PASS_ENTRY

# Default value for command line argument should be empty
BW_PASS_NAME_CLI=""

# Default Bitwarden secret
BW_DEFAULT_PASS_ENTRY="ansible-vault-main"

# Begin parsing command line arguments
print_usage() {
  echo "Usage: $0 [-e, --bw-entry BW_PASS_NAME]"
}

# Use getopt to parse the options
PARSED=$(getopt --options he: --long help,bw-entry: --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
  # getopt has complained about wrong arguments
  exit 2
fi

# Evaluate the parsed options
eval set -- "$PARSED"

# Process options
while true; do
  case "$1" in
    -h|--help)
      print_usage
      exit 0
      ;;
    -e|--bw-entry)
      BW_PASS_NAME_CLI="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unexpected option: $1" >&2
      exit 3
      ;;
  esac
done
# End parsing command line arguments

# Check if a variable for the Bitwarden secret was provided via cli or environment variable
check_env_var(){
    # Set default Bitwarden entry
    BW_PASS_ENTRY="$BW_DEFAULT_PASS_ENTRY"

    # If the environment variable is set, use that
    if [ -n "$BW_PASS_NAME" ]; then
      BW_PASS_ENTRY="$BW_PASS_NAME"
    fi

    # If we have a command line argument, use that instead
    if [ -n "$BW_PASS_NAME_CLI" ]; then
      BW_PASS_ENTRY="$BW_PASS_NAME_CLI"
    fi
}

# Check Bitwarden status
bw_status_parsing() {
    bw_status=$(bw status --session="$BW_SESSION" | jq -r '.status')
}

# Check Bitwarden Vault status locked/unlocked and echo the password
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
check_env_var
bw_status_parsing
bw_status_check_default