# ExAws.Timestream
![CI](https://github.com/mike-foucault/ex_aws_timestream/workflows/CI/badge.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/ex_aws_timestream.svg)](https://hex.pm/packages/ex_aws_timestream)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_aws_timestream/ExAws.Timestream.html)

## ExAws support notice

```elixir
defp deps do
  [
    {:ex_aws_timestream, "~> 0.2.0"},
    {:ex_aws, "~> 2.1.6"},
    {:jason, "~> 1.2"},
    {:hackney, "~> 1.16"},
  ]
end
```

Then 

```
AWS_ACCESS_KEY_ID="..." AWS_SECRET_ACCESS_KEY="..." iex -S mix
```

```elixir
ExAws.Timestream.list_databases
|> ExAws.request
```

