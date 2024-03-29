defmodule Highscore do
  @moduledoc """
  Documentation for `Highscore`.
  """
  def new() do
    # Please implement the new/0 function
    %{}
  end

  def add_player(scores, name, score \\ 0) do
    # Please implement the add_player/3 function
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    # Please implement the remove_player/2 function
    scores
    |> Enum.filter(fn {player, score} -> player != name end)
  end

  def reset_score(scores, name) do
    # Please implement the reset_score/2 function
   end

  def update_score(scores, name, score) do
    # Please implement the update_score/3 function
  end

  def get_players(scores) do
    scores
    # Please implement the get_players/1 function
  end
end

