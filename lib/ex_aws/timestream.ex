defmodule ExAws.Timestream do
  alias ExAws.Timestream.{Query, Write}

  @moduledoc """
  Operations on AWS Timestream
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Operations.html
  """

  ## Amazon Timestream Write
  ######################

  @doc "DescribeEndpoints returns a list of available endpoints to make Timestream Write API calls against"
  defdelegate describe_write_endpoints, to: Write, as: :describe_endpoints

  @doc "Creates a new Timestream database"
  defdelegate create_database(database_name, opts \\ []), to: Write
  @doc "Deletes a given Timestream database."
  defdelegate delete_database(database_name), to: Write
  @doc "Returns information about the database."
  defdelegate describe_database(database_name), to: Write
  @doc "Returns a list of your Timestream databases."
  defdelegate list_databases(opts \\ []), to: Write
  @doc "Modifies the KMS key for an existing database."
  defdelegate update_database(database_name, km_key_id), to: Write

  @doc "The CreateTable operation adds a new table to an existing database in your account."
  defdelegate create_table(database_name, table_name, opts \\ []), to: Write
  @doc "Deletes a given Timestream table."
  defdelegate delete_table(database_name, table_name), to: Write
  @doc "Returns information about the table."
  defdelegate describe_table(database_name, table_name), to: Write
  @doc "Returns a list of your Timestream tables."
  defdelegate list_tables(opts \\ []), to: Write

  @doc "Modifies the retention duration of the memory store and magnetic store for your Timestream table."
  defdelegate update_table(database_name, table_name, retention_properties), to: Write
  @doc "List all tags on a Timestream resource."
  defdelegate list_tags_for_resource(resource_arn), to: Write
  @doc "Associate a set of tags with a Timestream resource."
  defdelegate tag_resource(resource_arn, tags), to: Write
  @doc "Removes the association of tags from a Timestream resource."
  defdelegate untag_resource(resource_arn, tag_keys), to: Write

  @doc "The WriteRecords operation enables you to write your time series data into Timestream."
  defdelegate write_records(records, database_name, table_name, opts \\ []), to: Write

  ## Amazon Timestream Query
  ######################

  @doc "DescribeEndpoints returns a list of available endpoints to make Timestream Query API calls against"
  defdelegate describe_query_endpoints, to: Query, as: :describe_endpoints
  @doc "Cancels a query that has been issued."
  defdelegate cancel_query(query_id), to: Query
  @doc "Query is a synchronous operation that enables you to execute a query."
  defdelegate query(query_string, opts \\ []), to: Query
end
