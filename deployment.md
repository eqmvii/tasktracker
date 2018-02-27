# Deployment Guide

[Guide](https://hexdocs.pm/phoenix/heroku.html)

1. Heroku create, with elixir buildpack, ex. `heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git" #{name}`
2. Add Phoenix buildpack: `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
3. Modify `config/prod.exs` to have `,  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")`
4. Prepare your database

```
# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
``` 

5. Replace the URL line with

```
url: [scheme: "https", host: "mysterious-meadow-6277.herokuapp.com", port: 443],
force_ssl: [rewrite_on: [:x_forwarded_proto]],
```

6. Delete `import_config "prod.secret.exs"`
7. Increase timeout in user channel: `timeout: 45_000`
8. Create a Procfile named `Procfile` (no extension) including `web: MIX_ENV=prod mix phx.server`
9. Make a Heroku DB
10. Set the pool size `heroku config:set POOL_SIZE=18`