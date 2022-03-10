defmodule ExAws.Timestream.Write.MeasureValue do
  alias __MODULE__

  @moduledoc """
  Measure Value for the time-series data point.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_MeasureValue.html
  """

  defstruct name: [],
            value: nil,
            type: nil

  @type measure_value :: %MeasureValue{}

  @doc "Create a new MeasureValue struct"
  @spec new(name :: binary, value :: binary, type :: binary) :: measure_value()
  def new(name, value, type), do: %MeasureValue{name: name, value: value, type: type}
end
