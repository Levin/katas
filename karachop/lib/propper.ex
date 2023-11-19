defmodule Ropper do
  
  use GenServer
  require Logger


  def info() do
    GenServer.call(__MODULE__, :info)
  end

  def chop() do
    GenServer.cast(__MODULE__, :chop)
  end

  def start(list, search) do
    params = %{list: Enum.sort(list,:asc), search: search, found: false, found_by: nil}
    GenServer.start_link(__MODULE__, params, name: __MODULE__)
  end

  def init(params) do
    {:ok, params}
  end

  def handle_call(:info, from, state) do
    {:reply, state, state}
  end

  def handle_cast(:chop, state) do
    half = div(length(state.list), 2)
    mid = Enum.at(state.list, half)

    Logger.debug("[#{__MODULE__}] => list length(#{length(state.list)}) has half: #{half} and value #{mid}")
    Logger.debug("[#{__MODULE__}] => list looks like this: #{inspect state.list}")

    cond do
      mid == state.search -> 
        {:stop, :found, %{state | found: true, list: [mid], found_by: :algo}}
        
      mid >= state.search ->
        left = Enum.take(state.list, half)
        case catch_ends(left, state.search) do
          {:found, val} -> 
            Logger.debug("[#{__MODULE__}] found #{val} in late round !")
            {:stop, :found, %{state | found: true, list: [val], found_by: :levin}}

          {:not_found, _} -> 
            {:noreply, %{state | list: Enum.reverse(left)}}
        end
        {:noreply, %{state | list: left}}
      mid <= state.search -> 
        right = Enum.take(Enum.reverse(state.list), half)
        case catch_ends(right, state.search) do
          {:found, val} -> 
            {:stop, :found, %{state | found: true, list: [val], found_by: :levin}}

          {:not_found, _} -> 
            {:noreply, %{state | list: Enum.reverse(right)}}
        end
    end
  end

  def terminate(:found, state) do
    Logger.debug("[#{__MODULE__}] is done searching and found #{state.search}!!")
    IO.inspect({:found_by, state.found_by})
  end
  
  defp catch_ends(list, search) do
    first = List.first(list)
    last = List.last(list)
    
    num = cond do
      first == search -> {:found, first}
      last == search -> {:found, last}
      last != search && first != search -> {:not_found, nil}
    end


    Logger.debug("[#{__MODULE__}] searches #{search} and got #{inspect num}!")

    num
  end

end
