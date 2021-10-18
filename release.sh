cd assets && npm install && npm run kek
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix do deps.get, deps.compile