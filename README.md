# ExAws.Timestream
![CI](https://github.com/mike-foucault/ex_aws_timestream/workflows/CI/badge.svg)

## ExAws support notice

Timestream service is not yet supported by ex_aws.
[ExAws maintainer merged this PR](https://github.com/ex-aws/ex_aws/pull/716) in order to add valid configurations to ex_aws,
but ex_aws package has not been upgraded (v2.1.5)

Meanwhile, you can explore all timestream API methods by adding the following configuration :

```elixir
defp deps do
  [
    {:ex_aws_timestream, "~> 0.2.0"},
    {:ex_aws, git: "https://github.com/ex-aws/ex_aws.git", branch: "master", override: true},
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

