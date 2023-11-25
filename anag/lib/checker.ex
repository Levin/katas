defmodule Checker do
  use GenServer
  require Logger


  def check(word) do
    GenServer.cast(__MODULE__, {:check, word})
  end

  def check_binary_search(word) do
    GenServer.cast(__MODULE__, {:check_binary, word})
  end

  def uncheck() do
    GenServer.cast(__MODULE__, :uncheck)
  end

  def parse() do
    GenServer.cast(__MODULE__, :parse)
  end

  def parse_bin() do
    GenServer.cast(__MODULE__, :parse_bin)
  end

  def info() do
    GenServer.call(__MODULE__, :info)
  end

  def start(path \\ "./lib/words") do
    GenServer.start_link(__MODULE__, %{path: path}, name: __MODULE__)
  end

  def init(params) do
    {:ok, %{data: nil, numbers: nil, found: false, word: nil, file: params.path, took: nil, parse_took: nil}}
  end

  def handle_call(:info, _from, state) do
    {:reply, state, state} 
  end

  def handle_cast(:parse, state) do
    time = System.os_time()
    {:ok,file} = 
      File.read(state.file)
    data = 
      file
      |> String.split("\n")
      |> Enum.map(&parse(&1))

    n_time = System.os_time()
    {:noreply, %{state | data: data, parse_took: (n_time-time)/1000}}
  end

  def handle_cast(:parse_bin, state) do
    time = System.os_time()
    {:ok,file} = 
      File.read(state.file)
    data = 
      file
      |> String.split("\n")
      |> Enum.map(&parse(&1))

    nums = 
      file
      |> String.split("\n")
      |> Enum.map(&parse(&1, :bin))

    n_time = System.os_time()
    {:noreply, %{state | data: data, numbers: nums, parse_took: (n_time-time)/1000}}
  end

  def handle_cast({:check, word}, state) do
    time = System.os_time()

    parsed = word |> parse()

    case parsed in state.data do
      true -> 
        n_time = System.os_time()
        {:noreply, %{state | found: true, took: (n_time-time)/1000, word: {word, parsed}}}
      _ -> 
        n_time = System.os_time()
        {:noreply, %{state | took: (n_time-time)/1000, word: {word, parsed}}}
    end
  end

  def handle_cast({:check_binary, word}, state) do
    time = System.os_time()
    {:noreply, state}
  end

  def handle_cast({:check_binary, word}, state) do
    {:noreply, state}
  end

  def handle_cast(:uncheck, state) do
    {:noreply, %{state | found: false}}
  end
  
  defp parse(list, type \\ :str) do
    case type == :str do
  
      true -> 
        list
        |> String.graphemes()
        |> Enum.sort()

      false -> 
        list
        |> String.graphemes()
        |> Enum.map(&(:binary.first(&1)))
        |> Enum.sort()
    end
  end

end
