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

  def new(opts \\ []), do: struct!(Record, opts)

  def add_dimension(%Record{dimensions: dimensions} = record, dimension),
    do: %{record | dimensions: dimensions ++ [dimension]}
end
