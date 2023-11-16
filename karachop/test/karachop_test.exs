defmodule KarachopTest do
  use ExUnit.Case
  doctest Karachop

  test "greets the world" do
    assert Karachop.hello() == :world
  end
end
