#!/bin/bash

cd /app

bundle install

bin/rails db:setup
bin/rails db:migrate

rm -f /app/tmp/pids/server.pid

bin/dev
