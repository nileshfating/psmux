#!/usr/bin/env bash

# Update rmux pane title from bash prompt using cwd and last command.
# Usage:
#   source /path/to/scripts/rmux-title.sh
# This appends to PROMPT_COMMAND to run on every prompt.

__rmux_title_update() {
  local cwd
  cwd=$(basename -- "$PWD")
  local cmd
  # history 1 prints the last command; strip leading number
  cmd=$(history 1 2>/dev/null | sed 's/^ *[0-9]\+ *//')
  local title="$cwd"
  if [ -n "$cmd" ]; then
    title="$cwd: $cmd"
  fi
  rmux set-pane-title "$title" >/dev/null 2>&1 || true
}

case ":$PROMPT_COMMAND:" in
  *:__rmux_title_update:* ) ;; # already installed
  * ) PROMPT_COMMAND="__rmux_title_update${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac