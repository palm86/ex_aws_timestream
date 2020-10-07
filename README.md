# ExAws.Timestream

## Dev notes

Timestream service is not yet supported by ex_aws.
[A pull request is currently opened ](https://github.com/ex-aws/ex_aws/pull/716) in order to add valid configurations to ex_aws.

Meanwhile, you can explore all timestream API methods by adding the following configuration :

```elixir
defp deps do
  [
    {:ex_aws_timestream, "~> 0.2.0"},
    {:ex_aws, git: "https://github.com/mike-foucault/ex_aws.git", branch: "feat/add-timestream-support", override: true},
    {:jason, "~> 1.2"},
    {:hackney, "~> 1.16"},
  ]
end
```

Then 

```
AWS_ACCESS_KEY_ID="..." AWS_SECRET_ACCESS_KEY="..." iex -S mix
```
