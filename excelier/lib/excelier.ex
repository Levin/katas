defmodule Excelier do
  @moduledoc """
  Documentation for `Excelier`.
  """

  def read_data() do
    File.stream!("./lib/data.txt")
  end

  def runner() do
    data_stream = read_data()

    data_stream
    |> Enum.to_list()
    |> Enum.map(fn row ->
      [r, _] = String.split(row, "\n")
      r
    end)
    |> Enum.map(fn row ->
      case String.split(row, "x", trim: true) do
        [l, w, h] ->
          
          llww = String.to_integer(l) + String.to_integer(l) + String.to_integer(w) + String.to_integer(w)
          lwh =  String.to_integer(l) *  String.to_integer(w) *  String.to_integer(h)

          llww + lwh


        [] ->
          0
      end
    end)
    |> Enum.sum()
  end
end
