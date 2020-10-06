defmodule ExAws.Timestream.Write.Dimension do
  alias __MODULE__

  @moduledoc """
  Dimension represents the meta data attributes of the time series.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Dimension.html
  """

  @enforce_keys [:name, :value]
  defstruct name: nil, value: nil, dimension_value_type: nil

  @doc "Create a new Dimension struct"
  @spec new(name :: binary, value :: binary) :: %ExAws.Timestream.Write.Dimension{}
  def new(name, value), do: %Dimension{name: name, value: value}

  @doc "Create a new Dimension struct with a specific DimensionValueType"
  @spec new(name :: binary, value :: binary, dimension_value_type :: binary) ::
          %ExAws.Timestream.Write.Dimension{}
  def new(name, value, dimension_value_type),
    do: %Dimension{name: name, value: value, dimension_value_type: dimension_value_type}
end
