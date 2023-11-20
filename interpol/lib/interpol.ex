defmodule Interpol do
  require Logger

  @moduledoc """
  Documentation for `Interpol`.
  """

  @doc """
    Interpolation Search v.0
  """

  def run() do
    timer = System.monotonic_time()
    walk()
    runtime = System.monotonic_time()
    Logger.debug("** ran #{runtime - timer} **") 
    Process.exit(self(), :kill)
  end


  def walk(list \\ Enum.to_list(1..10), round \\ 0, search \\ 2, factor \\ nil) do

    lo = List.first(list)
    hi = List.last(list)

    Logger.debug("#{__MODULE__} -> liste: #{inspect(lo)}\n -> round: #{round}\n -> search: #{hi}\n")
    

    half_length = lo + Kernel.trunc((Enum.at(list,lo)*(hi-lo))/(hi-Enum.at(list, lo)))

    Logger.debug("#{__MODULE__} -> liste: #{inspect(lo)}\n -> round: #{round}\n -> search: #{hi}\n")

    half_elem = Enum.at(list, half_length)

    Logger.debug("#{__MODULE__} -> liste: #{inspect(list)}\n -> round: #{round}\n -> search: #{search}\n")

    {n_list, n_round} = cond do

      ### same ###  
      half_elem == search 
        -> 
        IO.inspect{:found, true}
        IO.inspect{:rounds, round}
        IO.inspect{:factor, factor}

        {:done, ""}


      ### grösser ###   => half_elem/guess was too low -> take right part###  
      half_elem < search 
        -> 
        # das ist sehr schlecht, geht für die kleinen listen hier aber -> 
        # FIXME: this is very bad performance wise so we will refaciotr this asap

        n_list = Enum.reverse(list) |> Enum.take(half_length) |> Enum.reverse()
        n_round = round+1
        Logger.debug("#{__MODULE__}(grösser) -> liste: #{inspect(n_list)}\n -> round: #{n_round}\n")
        {n_list, n_round}

      ### kleiner ###   => half_elem/guess was too high -> take left part###  
      half_elem > search -> :ok
        n_list = Enum.take(list, half_length)
        n_round = round+1
        Logger.debug("#{__MODULE__}(kleiner) -> liste: #{inspect(n_list)}\n -> round: #{n_round}\n")
        {n_list, n_round}
    end

    #case guesses(n_list) do
    #  :won -> 
    #  :continue -> 
    #        walk(n_list, n_round)
    #   endV

    if n_list != :done do
      walk(n_list, n_round)
    end

  end


  

end
