# Tasktracker

[View the app live](https://tasktracker-eqmvii.herokuapp.com/)

[Deployment info](deployment.md)

A simple to-do list app built with Phoenix by Eric Mancini

# Running and deploying

* Run with `mix phx.server`
* Run with an open iex connection: `iex -S mix phx.server`

# DB tasks

* Created DB via mix ecto.create
* Ran a generator: 

```

mix phx.gen.schema Admin admins name:string number_of_pets:integer

Sample code, not used:

mix phx.gen.schema User users name:string email:string bio:string number_of_pets:integer
mix phx.gen.schema Blog.Post blog_posts title:string views:integer

```

* Added an administrator:

```
iex -S mix
alias Tasktracker.{Repo, Admin}
Repo.insert(%Admin{name: "Eric Mancini", number_of_pets: 2})
Repo.all(Admin)
```

* Created a 2nd table simple table with a generator:

```
mix phx.gen.schema Task tasks name:string
mix ecto.migrate
```

* got greedy and grabbed another generator

```
mix phx.gen.html Todos Todo todos name:string priority:integer
mix ecto.migrate
```

* The world's simplest uther authentication, let's get going with another generator

```
mix phx.gen.html Accounts User users name:string age:integer password:string
```

# Phoenix boilerplate readme

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
