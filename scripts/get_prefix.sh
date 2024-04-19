#! /usr/bin/env bash

istmux() { [ -n "$TMUX" ]; }
talert() { tmux display -d 0 "#[bg=#{@color_info},fill=#{@color_info},fg=black] 󰭺 Message: $*"; }
terror() { tmux display -d 0 "#[bg=#{@color_error},fill=#{@color_error},fg=black]  Message: $*"; }
tsuccess() { tmux display -d 0 "#[bg=#{@color_success},fill=#{@color_success},fg=black]  Message: $*"; }

talert hi
