defmodule Recurse do
  require Logger
  @moduledoc """
  Documentation for `Recurse`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Recurse.hello()
      :world

  """

  def run() do
    result = calc(16, 0)
    Logger.debug("iterations needed: #{result}")
  end

  
  def calc(input, count) when rem(input, 2) == 0  do
    Logger.debug("even")
    Logger.debug("input: #{input}")
    Logger.debug("count: #{count}")
    calc(div(input, 2), count+1)
  end

  def calc(input, count) when rem(input, 2) != 0  do
    Logger.debug("odd")
    if(input == 1) do
      count
    else

      Logger.debug("input: #{input}")
      Logger.debug("count: #{count}")
      calc(input*3+1, count+1)
    end
  end

end
