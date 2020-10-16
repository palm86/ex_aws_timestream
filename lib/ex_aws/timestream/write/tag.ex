defmodule ExAws.Timestream.Write.Tag do
  alias __MODULE__

  @moduledoc """
  A tag is a label that you assign to a Timestream database and/or table.
  Each tag consists of a key and an optional value, both of which you define.
  Tags enable you to categorize databases and/or tables, for example, by purpose, owner, or environment.
  https://docs.aws.amazon.com/timestream/latest/developerguide/API_Tag.html
  """

  @type t :: %__MODULE__{}

  @enforce_keys [:key, :value]
  defstruct key: nil, value: nil

  @doc "Create a new Tag struct"
  @spec new(key :: binary, value :: binary) :: Tag.t()
  def new(key, value), do: %Tag{key: key, value: value}
end
