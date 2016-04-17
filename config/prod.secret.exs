use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :voting_service, VotingService.Endpoint,
  secret_key_base: "9Q+cZaDgeRJt6Q51rNL3MTQhL006fMk8MrAM5Jfs95EfX3YLWR5EXXWhJc1Kr6ig"

# Configure your database
config :voting_service, VotingService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "voting_service_prod",
  pool_size: 20
