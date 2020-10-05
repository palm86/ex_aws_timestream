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
      assert Timestream.describe_write_endpoints().data == %{}

      assert Enum.sort(Timestream.describe_write_endpoints().headers) == [
               {"content-type", "application/x-amz-json-1.0"},
               {"x-amz-target", "Timestream_20181101.DescribeEndpoints"}
             ]
    end

    test "#create_database/1" do
      assert Timestream.create_database("foo_bar").data == %{
               "DatabaseName" => "foo_bar",
               "KmsKeyId" => nil,
               "Tags" => []
             }
    end

    test "#create_database/2" do
      assert Timestream.create_database("foo_bar",
               tags: [{"foo", "bar"}],
               km_key_id: "fake_km_key_id"
             ).data == %{
               "DatabaseName" => "foo_bar",
               "KmsKeyId" => "fake_km_key_id",
               "Tags" => [%{"Key" => "foo", "Value" => "bar"}]
             }
    end

    test "#delete_database/1" do
      assert Timestream.delete_database("foo_bar").data == %{"DatabaseName" => "foo_bar"}
    end

    test "#describe_database/1" do
      assert Timestream.describe_database("foo_bar").data == %{"DatabaseName" => "foo_bar"}
    end

    test "#list_databases/0" do
      assert Timestream.list_databases().data == %{"MaxResults" => nil, "NextToken" => nil}
    end

    test "#list_databases/1" do
      assert Timestream.list_databases(max_results: 123, next_token: "foo_bar").data == %{
               "MaxResults" => 123,
               "NextToken" => "foo_bar"
             }
    end

    test "#update_database/2" do
      assert Timestream.update_database("database_name", "km_key_id").data == %{
               "DatabaseName" => "database_name",
               "KmsKeyId" => "km_key_id"
             }
    end

    test "#create_table/2" do
      assert Timestream.create_table("database_name", "table_name").data == %{
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

      assert Timestream.create_table("database_name", "table_name",
               tags: [{"foo", "bar"}],
               retention_properties: retention_properties
             ).data == %{
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
      assert Timestream.delete_table("database_name", "table_name").data == %{
               "DatabaseName" => "database_name",
               "TableName" => "table_name"
             }
    end

    test "#describe_table/2" do
      assert Timestream.describe_table("database_name", "table_name").data == %{
               "DatabaseName" => "database_name",
               "TableName" => "table_name"
             }
    end

    test "#list_tables/0" do
      assert Timestream.list_tables().data == %{
               "DatabaseName" => nil,
               "MaxResults" => nil,
               "NextToken" => nil
             }
    end

    test "#list_tables/1" do
      assert Timestream.list_tables(
               database_name: "database_name",
               max_results: 123,
               next_token: "foo_bar"
             ).data == %{
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

      assert Timestream.update_table("database_name", "table_name", retention_properties).data ==
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
      assert Timestream.list_tags_for_resource("resource_arn").data == %{
               "ResourceARN" => "resource_arn"
             }
    end

    test "#tag_resource/é" do
      assert Timestream.tag_resource("resource_arn", [{"foo", "bar"}]).data == %{
               "ResourceARN" => "resource_arn",
               "Tags" => [%{"Key" => "foo", "Value" => "bar"}]
             }
    end

    test "#untag_resource/2" do
      assert Timestream.untag_resource("resource_arn", ["foo", "bar"]).data == %{
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

      assert Timestream.write_records(records, "database_name", "table_name").data == %{
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

      assert Timestream.write_records(records, "database_name", "table_name",
               common_attributes: common_attributes
             ).data == %{
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
      assert Timestream.describe_query_endpoints().data == %{}

      assert Enum.sort(Timestream.describe_query_endpoints().headers) == [
               {"content-type", "application/x-amz-json-1.0"},
               {"x-amz-target", "Timestream_20181101.DescribeEndpoints"}
             ]
    end

    test "#cancel_query/1" do
      assert Timestream.cancel_query("query_id").data == %{"QueryId" => "query_id"}
    end

    test "#query/1" do
      assert Timestream.query("query_string").data == %{
               "ClientToken" => nil,
               "MaxRows" => nil,
               "NextToken" => nil,
               "QueryString" => "query_string"
             }
    end

    test "#query/2" do
      assert Timestream.query("query_string",
               client_token: "client_token",
               max_rows: 123,
               next_token: "next_token"
             ).data == %{
               "ClientToken" => "client_token",
               "MaxRows" => 123,
               "NextToken" => "next_token",
               "QueryString" => "query_string"
             }
    end
  end
end
