defmodule ExAws.TimestreamTest do
  use ExUnit.Case
  doctest ExAws.Timestream

  alias ExAws.Timestream

  alias ExAws.Timestream.Write.{
    Dimension,
    Record
  }

  describe "Amazon Timestream Write actions" do
    test "#describe_endpoints" do
      op = Timestream.describe_write_endpoints()
      assert op.data == %{}

      assert Enum.sort(op.headers) == describe_endpoint_headers()
    end

    test "#create_database/1" do
      op = Timestream.create_database("foo_bar")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "foo_bar",
               "KmsKeyId" => nil,
               "Tags" => []
             }
    end

    test "#create_database/2" do
      op =
        Timestream.create_database("foo_bar",
          tags: [{"foo", "bar"}],
          km_key_id: "fake_km_key_id"
        )

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "foo_bar",
               "KmsKeyId" => "fake_km_key_id",
               "Tags" => [%{"Key" => "foo", "Value" => "bar"}]
             }
    end

    test "#delete_database/1" do
      op = Timestream.delete_database("foo_bar")
      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()
      assert op.request_operation.data == %{"DatabaseName" => "foo_bar"}
    end

    test "#describe_database/1" do
      op = Timestream.describe_database("foo_bar")
      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()
      assert op.request_operation.data == %{"DatabaseName" => "foo_bar"}
    end

    test "#list_databases/0" do
      op = Timestream.list_databases()

      assert Enum.sort(op.endpoint_operation.headers) ==
               describe_endpoint_headers()

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "MaxResults" => nil,
               "NextToken" => nil
             }
    end

    test "#list_databases/1" do
      op = Timestream.list_databases(max_results: 123, next_token: "foo_bar")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data ==
               %{
                 "MaxResults" => 123,
                 "NextToken" => "foo_bar"
               }
    end

    test "#update_database/2" do
      op = Timestream.update_database("database_name", "km_key_id")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "KmsKeyId" => "km_key_id"
             }
    end

    test "#create_table/2" do
      op = Timestream.create_table("database_name", "table_name")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "RetentionProperties" => nil,
               "TableName" => "table_name",
               "Tags" => []
             }
    end

    test "#create_table/3" do
      retention_properties = %{
        magnetic_retention: "magnetic_retention",
        memory_retention: "memory_retention"
      }

      op =
        Timestream.create_table("database_name", "table_name",
          tags: [{"foo", "bar"}],
          retention_properties: retention_properties
        )

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "RetentionProperties" => %{
                 "MagneticStoreRetentionPeriodInDays" => "magnetic_retention",
                 "MemoryStoreRetentionPeriodInHours" => "memory_retention"
               },
               "TableName" => "table_name",
               "Tags" => [%{"Key" => "foo", "Value" => "bar"}]
             }
    end

    test "#delete_table/2" do
      op = Timestream.delete_table("database_name", "table_name")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "TableName" => "table_name"
             }
    end

    test "#describe_table/2" do
      op = Timestream.describe_table("database_name", "table_name")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "TableName" => "table_name"
             }
    end

    test "#list_tables/0" do
      op = Timestream.list_tables()

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => nil,
               "MaxResults" => nil,
               "NextToken" => nil
             }
    end

    test "#list_tables/1" do
      op =
        Timestream.list_tables(
          database_name: "database_name",
          max_results: 123,
          next_token: "foo_bar"
        )

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "DatabaseName" => "database_name",
               "MaxResults" => 123,
               "NextToken" => "foo_bar"
             }
    end

    test "#update_table/3" do
      retention_properties = %{
        magnetic_retention: "magnetic_retention",
        memory_retention: "memory_retention"
      }

      op = Timestream.update_table("database_name", "table_name", retention_properties)

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data ==
               %{
                 "DatabaseName" => "database_name",
                 "RetentionProperties" => %{
                   "MagneticStoreRetentionPeriodInDays" => "magnetic_retention",
                   "MemoryStoreRetentionPeriodInHours" => "memory_retention"
                 },
                 "TableName" => "table_name"
               }
    end

    test "#list_tags_for_resource/1" do
      op = Timestream.list_tags_for_resource("resource_arn")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "ResourceARN" => "resource_arn"
             }
    end

    test "#tag_resource/2" do
      op = Timestream.tag_resource("resource_arn", [{"foo", "bar"}])

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "ResourceARN" => "resource_arn",
               "Tags" => [%{"Key" => "foo", "Value" => "bar"}]
             }
    end

    test "#untag_resource/2" do
      op = Timestream.untag_resource("resource_arn", ["foo", "bar"])

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "ResourceARN" => "resource_arn",
               "TagKeys" => ["foo", "bar"]
             }
    end

    test "#write_records/3" do
      records = [
        Record.new(
          measure_name: "measure_name",
          measure_value: "measure_value",
          measure_value_type: "measure_value_type",
          time: "time",
          time_unit: "time_unit"
        )
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value")),
        Record.new()
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value"))
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value", "dimension_value_type"))
      ]

      op = Timestream.write_records(records, "database_name", "table_name")

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "CommonAttributes" => nil,
               "DatabaseName" => "database_name",
               "Records" => [
                 %{
                   "Dimensions" => [
                     %{
                       "DimensionValueType" => nil,
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     }
                   ],
                   "MeasureName" => "measure_name",
                   "MeasureValue" => "measure_value",
                   "MeasureValueType" => "measure_value_type",
                   "Time" => "time",
                   "TimeUnit" => "time_unit"
                 },
                 %{
                   "Dimensions" => [
                     %{
                       "DimensionValueType" => nil,
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     },
                     %{
                       "DimensionValueType" => "dimension_value_type",
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     }
                   ],
                   "MeasureName" => nil,
                   "MeasureValue" => nil,
                   "MeasureValueType" => nil,
                   "Time" => nil,
                   "TimeUnit" => nil
                 }
               ],
               "TableName" => "table_name"
             }
    end

    test "#write_records/4" do
      records = [
        Record.new(
          measure_name: "measure_name",
          measure_value: "measure_value",
          measure_value_type: "measure_value_type",
          time: "time",
          time_unit: "time_unit"
        )
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value")),
        Record.new()
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value"))
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value", "dimension_value_type"))
      ]

      common_attributes =
        Record.new()
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value"))
        |> Record.add_dimension(Dimension.new("fake_name", "fake_value", "dimension_value_type"))

      op =
        Timestream.write_records(records, "database_name", "table_name",
          common_attributes: common_attributes
        )

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "CommonAttributes" => %{
                 "Dimensions" => [
                   %{"DimensionValueType" => nil, "Name" => "fake_name", "Value" => "fake_value"},
                   %{
                     "DimensionValueType" => "dimension_value_type",
                     "Name" => "fake_name",
                     "Value" => "fake_value"
                   }
                 ],
                 "MeasureName" => nil,
                 "MeasureValue" => nil,
                 "MeasureValueType" => nil,
                 "Time" => nil,
                 "TimeUnit" => nil
               },
               "DatabaseName" => "database_name",
               "Records" => [
                 %{
                   "Dimensions" => [
                     %{
                       "DimensionValueType" => nil,
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     }
                   ],
                   "MeasureName" => "measure_name",
                   "MeasureValue" => "measure_value",
                   "MeasureValueType" => "measure_value_type",
                   "Time" => "time",
                   "TimeUnit" => "time_unit"
                 },
                 %{
                   "Dimensions" => [
                     %{
                       "DimensionValueType" => nil,
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     },
                     %{
                       "DimensionValueType" => "dimension_value_type",
                       "Name" => "fake_name",
                       "Value" => "fake_value"
                     }
                   ],
                   "MeasureName" => nil,
                   "MeasureValue" => nil,
                   "MeasureValueType" => nil,
                   "Time" => nil,
                   "TimeUnit" => nil
                 }
               ],
               "TableName" => "table_name"
             }
    end
  end

  describe "Amazon Timestream Query actions" do
    test "#describe_endpoints" do
      op = Timestream.describe_query_endpoints()
      assert op.data == %{}

      assert Enum.sort(op.headers) == describe_endpoint_headers()
    end

    test "#cancel_query/1" do
      op = Timestream.cancel_query("query_id")
      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()
      assert op.request_operation.data == %{"QueryId" => "query_id"}
    end

    test "#query/1" do
      op = Timestream.query("query_string")
      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "ClientToken" => nil,
               "MaxRows" => nil,
               "NextToken" => nil,
               "QueryString" => "query_string"
             }
    end

    test "#query/2" do
      op =
        Timestream.query("query_string",
          client_token: "client_token",
          max_rows: 123,
          next_token: "next_token"
        )

      assert Enum.sort(op.endpoint_operation.headers) == describe_endpoint_headers()

      assert op.request_operation.data == %{
               "ClientToken" => "client_token",
               "MaxRows" => 123,
               "NextToken" => "next_token",
               "QueryString" => "query_string"
             }
    end
  end

  defp describe_endpoint_headers do
    [
      {"content-type", "application/x-amz-json-1.0"},
      {"x-amz-target", "Timestream_20181101.DescribeEndpoints"}
    ]
    |> Enum.sort()
  end
end
