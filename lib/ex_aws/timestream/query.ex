defmodule ExAws.Timestream.Query do
  @namespace "Timestream_20181101"

  @moduledoc """
  The following actions are supported by Amazon Timestream Query.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Operations_Amazon_Timestream_Query.html
  """

  @doc "DescribeEndpoints returns a list of available endpoints to make Timestream API calls against"
  @spec describe_endpoints() :: ExAws.Operation.JSON.t()
  def describe_endpoints do
    request(:describe_endpoints, %{})
  end

  @doc "Cancels a query that has been issued."
  @spec cancel_query(query_id :: binary) :: ExAws.Operation.JSON.t()
  def cancel_query(query_id) do
    request(:describe_endpoints, %{
      "QueryId" => query_id
    })
  end

  @doc "Query is a synchronous operation that enables you to execute a query."
  @type query_opts :: [
          {:max_rows, pos_integer}
          | {:next_token, binary}
          | {:client_token, binary}
        ]
  @spec query(query_string :: binary) :: ExAws.Operation.JSON.t()
  @spec query(query_string :: binary, query_opts :: query_opts) :: ExAws.Operation.JSON.t()
  def query(query_string, opts \\ []) do
    request(:query, %{
      "ClientToken" => Keyword.get(opts, :client_token, nil),
      "MaxRows" => Keyword.get(opts, :max_rows, nil),
      "NextToken" => Keyword.get(opts, :next_token, nil),
      "QueryString" => query_string
    })
  end

  defp request(op, data) do
    operation =
      op
      |> Atom.to_string()
      |> Macro.camelize()

    %ExAws.Operation.JSON{
      http_method: :post,
      service: :query_timestream,
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.0"}
      ]
    }
  end
end
