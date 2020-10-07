defmodule ExAws.Timestream.Write do
  import ExAws.Utils, only: [camelize_keys: 2]
  @namespace "Timestream_20181101"

  @moduledoc """
  The following actions are supported by Amazon Timestream Write.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Operations_Amazon_Timestream_Write.html
  """

  @type database_name :: binary
  @type table_name :: binary

  @type tag :: {binary, binary}
  @type tags :: list(tag)

  @type retention_properties :: %{
          magnetic_retention: pos_integer,
          memory_retention: pos_integer
        }

  @type resource_arn :: binary
  @type record :: %ExAws.Timestream.Write.Record{}

  @doc "DescribeEndpoints returns a list of available endpoints to make Timestream API calls against"
  @spec describe_endpoints() :: ExAws.Operation.JSON.t()
  def describe_endpoints do
    endpoint_operation()
  end

  ## Amazon Timestream Write : Database
  ######################

  @doc "Creates a new Timestream database"
  @type create_database_opts :: [
          {:km_key_id, pos_integer}
          | {:tags, tags}
        ]
  @spec create_database(database_name :: database_name) :: ExAws.Operation.JSON.t()
  @spec create_database(database_name :: database_name, opts :: create_database_opts) ::
          ExAws.Operation.JSON.t()
  def create_database(database_name, opts \\ []) do
    request(:create_database, %{
      "DatabaseName" => database_name,
      "KmsKeyId" => Keyword.get(opts, :km_key_id, nil),
      "Tags" => Keyword.get(opts, :tags, []) |> build_tags
    })
    |> dynamic_endpoint_request()
  end

  defp build_tags(tags) do
    tags
    |> Enum.map(fn {key, value} ->
      %{
        "Key" => key,
        "Value" => value
      }
    end)
  end

  @doc "Deletes a given Timestream database."
  @spec delete_database(database_name :: database_name) :: ExAws.Operation.JSON.t()
  def delete_database(database_name) do
    request(:delete_database, %{"DatabaseName" => database_name})
    |> dynamic_endpoint_request()
  end

  @doc "Returns information about the database."
  @spec describe_database(database_name :: database_name) :: ExAws.Operation.JSON.t()
  def describe_database(database_name) do
    request(:describe_database, %{"DatabaseName" => database_name})
    |> dynamic_endpoint_request()
  end

  @doc "Returns a list of your Timestream databases."
  @type list_databases_opts :: [
          {:max_results, pos_integer}
          | {:next_token, binary}
        ]
  @spec list_databases() :: ExAws.Operation.JSON.t()
  @spec list_databases(list_databases_opts :: list_databases_opts) :: ExAws.Operation.JSON.t()
  def list_databases(opts \\ []) do
    request(:list_databases, %{
      "MaxResults" => Keyword.get(opts, :max_results, nil),
      "NextToken" => Keyword.get(opts, :next_token, nil)
    })
    |> dynamic_endpoint_request()
  end

  @doc "Modifies the KMS key for an existing database."
  @spec update_database(database_name :: database_name, km_key_id :: pos_integer) ::
          ExAws.Operation.JSON.t()
  def update_database(database_name, km_key_id) do
    request(:update_database, %{
      "DatabaseName" => database_name,
      "KmsKeyId" => km_key_id
    })
    |> dynamic_endpoint_request()
  end

  ## Amazon Timestream Write : Table
  ######################

  @doc "The CreateTable operation adds a new table to an existing database in your account."
  @type create_table_opts :: [
          {:tags, tags}
          | {:retention_properties, retention_properties}
        ]
  @spec create_table(database_name :: database_name, km_key_id :: table_name) ::
          ExAws.Operation.JSON.t()
  @spec create_table(
          database_name :: database_name,
          km_key_id :: table_name,
          create_table_opts :: create_table_opts
        ) :: ExAws.Operation.JSON.t()
  def create_table(database_name, table_name, opts \\ []) do
    request(:create_table, %{
      "DatabaseName" => database_name,
      "TableName" => table_name,
      "Tags" => Keyword.get(opts, :tags, []) |> build_tags,
      "RetentionProperties" =>
        Keyword.get(opts, :retention_properties, nil) |> build_retention_properties
    })
    |> dynamic_endpoint_request()
  end

  defp build_retention_properties(retention_properties) when is_nil(retention_properties), do: nil

  defp build_retention_properties(%{
         magnetic_retention: magnetic_retention,
         memory_retention: memory_retention
       }) do
    %{
      "MagneticStoreRetentionPeriodInDays" => magnetic_retention,
      "MemoryStoreRetentionPeriodInHours" => memory_retention
    }
  end

  @doc "Deletes a given Timestream table."
  @spec delete_table(database_name :: database_name, km_key_id :: table_name) ::
          ExAws.Operation.JSON.t()
  def delete_table(database_name, table_name) do
    request(:delete_table, %{
      "DatabaseName" => database_name,
      "TableName" => table_name
    })
    |> dynamic_endpoint_request()
  end

  @doc "Returns information about the table."
  @spec describe_table(database_name :: database_name, km_key_id :: table_name) ::
          ExAws.Operation.JSON.t()
  def describe_table(database_name, table_name) do
    request(:describe_table, %{
      "DatabaseName" => database_name,
      "TableName" => table_name
    })
    |> dynamic_endpoint_request()
  end

  @doc "Returns a list of your Timestream tables."
  @type list_tables_opts :: [
          {:database_name, database_name}
          | {:max_results, pos_integer}
          | {:next_token, binary}
        ]
  @spec list_tables() :: ExAws.Operation.JSON.t()
  @spec list_tables(list_tables_opts) :: ExAws.Operation.JSON.t()
  def list_tables(opts \\ []) do
    request(:list_tables, %{
      "DatabaseName" => Keyword.get(opts, :database_name, nil),
      "MaxResults" => Keyword.get(opts, :max_results, nil),
      "NextToken" => Keyword.get(opts, :next_token, nil)
    })
    |> dynamic_endpoint_request()
  end

  @doc "Modifies the retention duration of the memory store and magnetic store for your Timestream table."
  @spec update_table(
          database_name :: database_name,
          km_key_id :: table_name,
          retention_properties :: retention_properties
        ) :: ExAws.Operation.JSON.t()
  def update_table(database_name, table_name, retention_properties) do
    request(:update_table, %{
      "DatabaseName" => database_name,
      "TableName" => table_name,
      "RetentionProperties" => retention_properties |> build_retention_properties
    })
    |> dynamic_endpoint_request()
  end

  ## Amazon Timestream Write : TagResource
  ######################

  @doc "List all tags on a Timestream resource."
  @spec list_tags_for_resource(resource_arn :: resource_arn) :: ExAws.Operation.JSON.t()
  def list_tags_for_resource(resource_arn) do
    request(:list_tags_for_resource, %{
      "ResourceARN" => resource_arn
    })
    |> dynamic_endpoint_request()
  end

  @doc "Associate a set of tags with a Timestream resource."
  @spec tag_resource(resource_arn :: resource_arn, tags :: tags) :: ExAws.Operation.JSON.t()
  def tag_resource(resource_arn, tags) do
    request(:tag_resource, %{
      "ResourceARN" => resource_arn,
      "Tags" => tags |> build_tags
    })
    |> dynamic_endpoint_request()
  end

  @doc "Removes the association of tags from a Timestream resource."
  @spec untag_resource(resource_arn :: resource_arn, tag_keys :: [binary]) ::
          ExAws.Operation.JSON.t()
  def untag_resource(resource_arn, tag_keys) do
    request(:untag_resource, %{
      "ResourceARN" => resource_arn,
      "TagKeys" => tag_keys
    })
    |> dynamic_endpoint_request()
  end

  ## Amazon Timestream Write : time series data
  ######################

  @doc "The WriteRecords operation enables you to write your time series data into Timestream."
  @type write_records_opts :: [
          {:common_attributes, record}
        ]
  @spec write_records(
          records :: [record],
          database_name :: database_name,
          table_name :: table_name
        ) :: ExAws.Operation.JSON.t()
  @spec write_records(
          records :: [record],
          database_name :: database_name,
          table_name :: table_name,
          write_records :: write_records_opts
        ) :: ExAws.Operation.JSON.t()
  def write_records(records, database_name, table_name, opts \\ []) do
    request(:write_records, %{
      "DatabaseName" => database_name,
      "TableName" => table_name,
      "Records" => Enum.map(records, &build_record/1),
      "CommonAttributes" => Keyword.get(opts, :common_attributes, nil) |> build_record
    })
    |> dynamic_endpoint_request()
  end

  def build_record(record) when is_nil(record), do: nil

  def build_record(record) do
    record
    |> Map.from_struct()
    |> Map.update!(:dimensions, fn current_dimensions ->
      current_dimensions
      |> Enum.map(fn dimension ->
        dimension
        |> Map.from_struct()
        |> camelize_keys(deep: false)
      end)
    end)
    |> camelize_keys(deep: false)
  end

  defp request(op, data) do
    ExAws.Operation.JSON.new(
      :ingest_timestream,
      http_method: :post,
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{format_operation_name(op)}"},
        {"content-type", "application/x-amz-json-1.0"}
      ]
    )
  end

  defp format_operation_name(operation) do
    operation
    |> Atom.to_string()
    |> Macro.camelize()
  end

  defp dynamic_endpoint_request(request_op, endpoint_op \\ endpoint_operation()) do
    ExAws.Operation.JsonWithEndpointDiscovery.new(:ingest_timestream,
      request_operation: request_op,
      endpoint_operation: endpoint_op
    )
  end

  defp endpoint_operation() do
    request(:describe_endpoints, %{})
  end
end
