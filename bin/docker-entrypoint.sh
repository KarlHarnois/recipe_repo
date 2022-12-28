#!/usr/bin/env bash

bundle exec rails assets:precompile

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate
echo "PostgreSQL database has been created & migrated!"

rm -f tmp/pids/server.pid

bundle exec rails server -p 9292 -b 0.0.0.0
