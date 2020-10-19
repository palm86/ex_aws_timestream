# ExAws.Timestream

Service module for [https://github.com/ex-aws/ex_aws](https://github.com/ex-aws/ex_aws)

[![Hex.pm](https://img.shields.io/hexpm/v/ex_aws_timestream.svg)](https://hex.pm/packages/ex_aws_timestream)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_aws_timestream/ExAws.Timestream.html)

## Installation

The package can be installed by adding `ex_aws_timestream` to your list of dependencies in `mix.exs` along with `:ex_aws` and your preferred JSON codec / http client

```elixir
defp deps do
  [
    {:ex_aws, "~> 2.1.6"},
    {:ex_aws_timestream, "~> 0.4.0"},
    {:jason, "~> 1.2"},
    {:hackney, "~> 1.16"},
  ]
end
```

## Example

```elixir
ExAws.Timestream.list_databases
|> ExAws.request
```
