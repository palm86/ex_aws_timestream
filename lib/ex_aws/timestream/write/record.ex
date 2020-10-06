defmodule ExAws.Timestream.Write.Record do
  alias __MODULE__

  @moduledoc """
  Record represents a time series data point being written into Timestream.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Record.html
  """

  defstruct dimensions: [],
            measure_name: nil,
            measure_value: nil,
            measure_value_type: nil,
            time: nil,
            time_unit: nil

  @type record :: %ExAws.Timestream.Write.Record{}
  @type dimension :: %ExAws.Timestream.Write.Dimension{}

  @doc "Create a new Record struct"
  @type new_opts :: %{
          dimensions: [dimension],
          measure_name: binary,
          measure_value: binary,
          measure_value_type: binary,
          time: binary,
          time_unit: binary
        }
  @spec new(new_opts :: new_opts) :: record
  def new(opts \\ []), do: struct!(Record, opts)

  @doc "Add a dimension to a record struct"
  @spec add_dimension(record :: record, dimension :: dimension) :: record
  def add_dimension(%Record{dimensions: dimensions} = record, dimension),
    do: %{record | dimensions: dimensions ++ [dimension]}
end
