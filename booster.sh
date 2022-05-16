#!/bin/sh

set -e

tmux split-window -vh 'cd shu-han-training; bin/webpack-dev-server'
bin/rails server
