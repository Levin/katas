defmodule ExcelierTest do
  use ExUnit.Case
  doctest Excelier

  test "greets the world" do
    assert Excelier.hello() == :world
  end
end
