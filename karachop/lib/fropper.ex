defmodule Fropper do
  
  require Logger



  def walk(list \\ Enum.to_list(0..20), rounds \\ 0, search \\ :rand.uniform(20)) do

    half_length = div(length(list), 2)
    half_item = Enum.at(list, half_length)

    cond do 
      half_item == search -> 
        :found
        Logger.debug("** [#{__MODULE__}] found #{search} after rounds #{rounds} ** ")
        Process.exit(self(), :kill)

      half_item > search ->
        Logger.debug("** [#{__MODULE__}] is with #{inspect list} in round #{rounds} ** ")
        new_round = rounds + 1
        walk(Enum.take(list, half_length), new_round)
      half_item < search -> 
        Logger.debug("** [#{__MODULE__}] is with #{inspect list} in round #{rounds} ** ")
        new_round = rounds + 1
        walk(Enum.reverse(Enum.take(Enum.reverse(list), half_length)), new_round)
    end
  end


 



end
