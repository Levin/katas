defmodule Tropper do
  
  @moduledoc """
    this type of binary search makes the normal trunctation of the left/right part It then makes a short random search by generating a random number and checking that index in the remaining list.
  """

  use GenServer
  require Logger

  def chop() do
    GenServer.cast(__MODULE__, :chop)
  end

  def status() do  
    GenServer.call(__MODULE__, :info)
  end

  def start(list, search) do
    params = %{list: list, search: search, found: false}
    GenServer.start_link(__MODULE__, params, name: __MODULE__)
  end

  def init(params) do
    {:ok, params}
  end

  def handle_cast(:chop, status) do
    mid_num = Enum.at(status.list, div(length(status.list), 2))

    Logger.debug("currently looking at #{mid_num}")

    cond do
      mid_num == status.search -> 
        Logger.debug("currently compared #{mid_num} with #{status.search}")
        {:noreply, %{status | list: [mid_num], found: true}}
      mid_num > status.search ->
        Logger.debug("currently compared #{mid_num} with #{status.search}")
        new_list = Enum.slice(status.list, 0, div(length(status.list), 2))
        case random_check(new_list) == status.search do
          true -> {:noreply, %{status | list: [mid_num], found: true}}
          _ -> {:noreply, %{status | list: new_list}}
        end
      mid_num < status.search -> 
        Logger.debug("currently compared #{mid_num} with #{status.search}")
        new_list = Enum.slice(status.list, div(length(status.list), 2), length(status.list))
        case random_check(new_list) == status.search do
          true -> {:noreply, %{status | list: [mid_num], found: true}}
          _ -> {:noreply, %{status | list: new_list}}
        end
    end

  end

  def handle_call(:info, _from, state) do
    {:reply,state,  state}
  end

  defp random_check(list) do
    list_length = length(list)
    rand_num = :random.uniform(list_length)
    Logger.debug("[#{__MODULE__}] is testing this number now: #{Enum.at(list, rand_num)}")
    Enum.at(list, rand_num)
  end





end
