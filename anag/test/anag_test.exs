defmodule AnagTest do
  use ExUnit.Case
  doctest Anag

  test "greets the world" do
    assert Anag.hello() == :world
  end
end
