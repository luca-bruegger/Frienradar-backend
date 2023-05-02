#!/bin/bash

set -e

rm -f tmp/pids/server.pid

echo "⚙️ Installing gems for $RAILS_ENV environment"
bundle install

if [ -z "$SKIP_RAILS_MIGRATIONS" ]; then
  echo "⚙️ Performing migrations"
  bundle exec rails db:create db:migrate
  echo "✅ Migrations done"
fi

if [ -z "$SKIP_SEEDS" ]; then
  if [ ! -f .seed_done ]; then
    echo "⚙️ Seeding db"
    bundle exec rails db:seed && date > .seed_done
    echo "✅ Seeding done"
  else
    echo "↪️ Skipping seeding because already done on $(cat .seed_done)"
  fi
fi

echo "➡️ Handing control over to '$*''"

echo "⚙️ Executing: $@"
exec bundle exec "$@"