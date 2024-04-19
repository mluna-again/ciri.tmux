#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

terror() { tmux display -d 0 "#[bg=#{@color_error},fill=#{@color_error},fg=black]  Message: $*"; }

(
  cd "$CURRENT_DIR/scripts" || exit
  go build -o ciritmux || exit
  mv ciritmux "$HOME/.local/bin" || exit
) || {
  terror "[ciri.tmux] could not compile ciri! do you have go installed?"
  exit
}

tmux bind-key S run-shell "$CURRENT_DIR/scripts/ciri.sh"
