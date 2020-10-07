defmodule ExAws.Timestream do
  alias ExAws.Timestream.{Query, Write}

  @moduledoc """
  Operations on AWS Timestream
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Operations.html
  """

  ## Amazon Timestream Write
  ######################

  @doc deletegate_to: {ExAws.Timestream.Write, :describe_endpoints, 0}
  defdelegate describe_write_endpoints, to: Write, as: :describe_endpoints

  @doc deletegate_to: {ExAws.Timestream.Write, :create_database, 2}
  defdelegate create_database(database_name, opts \\ []), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :delete_database, 1}
  defdelegate delete_database(database_name), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :describe_database, 1}
  defdelegate describe_database(database_name), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :list_databases, 1}
  defdelegate list_databases(opts \\ []), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :update_database, 2}
  defdelegate update_database(database_name, km_key_id), to: Write

  @doc deletegate_to: {ExAws.Timestream.Write, :create_table, 3}
  defdelegate create_table(database_name, table_name, opts \\ []), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :delete_table, 2}
  defdelegate delete_table(database_name, table_name), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :describe_table, 2}
  defdelegate describe_table(database_name, table_name), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :list_tables, 1}
  defdelegate list_tables(opts \\ []), to: Write

  @doc deletegate_to: {ExAws.Timestream.Write, :update_table, 3}
  defdelegate update_table(database_name, table_name, retention_properties), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :list_tags_for_resource, 1}
  defdelegate list_tags_for_resource(resource_arn), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :tag_resource, 2}
  defdelegate tag_resource(resource_arn, tags), to: Write
  @doc deletegate_to: {ExAws.Timestream.Write, :untag_resource, 2}
  defdelegate untag_resource(resource_arn, tag_keys), to: Write

  @doc deletegate_to: {ExAws.Timestream.Write, :write_records, 4}
  defdelegate write_records(records, database_name, table_name, opts \\ []), to: Write

  ## Amazon Timestream Query
  ######################

  @doc deletegate_to: {ExAws.Timestream.Query, :describe_query_endpoints, 0}
  defdelegate describe_query_endpoints, to: Query, as: :describe_endpoints
  @doc deletegate_to: {ExAws.Timestream.Query, :cancel_query, 1}
  defdelegate cancel_query(query_id), to: Query
  @doc deletegate_to: {ExAws.Timestream.Query, :query, 2}
  defdelegate query(query_string, opts \\ []), to: Query
end
