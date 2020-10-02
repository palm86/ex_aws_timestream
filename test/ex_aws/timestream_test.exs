defmodule ExAws.TimestreamTest do
  use ExUnit.Case
  doctest ExAws.Timestream

  test "greets the world" do
    assert ExAws.Timestream.hello() == :world
  end
end
