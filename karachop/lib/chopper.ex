defmodule Chopper do
  
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

  @impl true
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
        {:noreply, %{status | list: new_list}}
      mid_num < status.search -> 
        Logger.debug("currently compared #{mid_num} with #{status.search}")
        new_list = Enum.slice(status.list, div(length(status.list), 2), length(status.list))
        {:noreply, %{status | list: new_list}}
    end

      
  end


  def handle_call(:info, _from, state) do
    {:reply,state,  state}
  end




end
