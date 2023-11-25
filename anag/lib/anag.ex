defmodule Anag do

  def check_word(word) do
    timer = System.os_time()
    words = run()
    found? = Enum.sort(String.graphemes(word))
    case found? in words do
      true -> 
        timex = System.os_time()
        {:found, timex-timer/1000, found?}


      false -> 
        timex = System.os_time()
        {:not_found, timex-timer/1000}
    end


  end

  def run(path \\ "./lib/words") do
    File.stream!(path)
    |> Stream.map(&String.split(&1, "\n") |> List.first())
    |> Stream.map(&chop/1)
    |> Enum.to_list()
  end

  defp chop(word) do
    String.graphemes(word) |> Enum.sort()
  end
  



end
