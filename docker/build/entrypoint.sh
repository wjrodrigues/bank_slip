#!/bin/bash

cd /app

bundle install

bin/rails db:setup
bin/rails db:migrate

bin/dev
