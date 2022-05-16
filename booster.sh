#!/bin/sh

set -e

tmux split-window -bf 'redis-server'
tmux split-window -bf 'bin/webpack-dev-server'
tmux split-window -fh 'bin/rails server'
bundle exec sidekiq

