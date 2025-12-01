#!/usr/bin/env bash# exiton error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean