#!/bin/bash

cd /app

bundle install

bin/rails db:setup
bin/rails db:migrate

bin/rails s -b 0.0.0.0 -p 8080
