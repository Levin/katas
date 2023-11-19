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
    params = %{list: list, search: search, found: false}
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
    cond do
      mid == state.search -> 
        {:noreply, %{state | found: true}}
      mid >= state.search ->
        left = Enum.take(state.list, half)
        {:noreply, %{state | list: left}}
      mid <= state.search -> 
        right = Enum.take(Enum.reverse(state.list), half)
        {:noreply, %{state | list: Enum.reverse(right)}}
    end

  end


end
