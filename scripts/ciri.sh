#! /usr/bin/env bash

TTY=$(tmux display -p "#{pane_tty}")

tmux set alternate-screen on

alternate() {
  if [ "$1" = on ]; then
    tput smcup
    return
  fi

  tput rmcup
}

content=$(tmux capture-pane -p)

alternate on

function cleanup {
  alternate off
}

trap cleanup EXIT

# MAIN LOOP
clear
ciritmux -tty "$TTY" <<< "$content"
sleep 3
