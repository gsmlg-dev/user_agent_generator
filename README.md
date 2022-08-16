# UserAgent.Generator

[![release](https://github.com/gsmlg-dev/user_agent_generator/actions/workflows/test-and-release.yml/badge.svg)](https://github.com/gsmlg-dev/user_agent_generator/actions/workflows/test-and-release.yml)

This package is for generate User-Agent string case.

See the [docs](https://hexdocs.pm/user_agent_generator/) for more information.

## API

```elixir
UserAgent.random()
# return random user-agent string from most common

UserAgent.random_all()
# return random user-agent string from all
```

## Install this package

Add deps in `mix.exs`

```elixir
    {:user_agent_generator, "~> 0.0.0"},
```



