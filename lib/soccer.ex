defmodule Soccer do
  @moduledoc """
  Documentation for Soccer.
  """


  def leagues do
    SoccerParser.stream()
    |> Flow.map(fn row -> Enum.at(row, 1) end)
    |> Enum.to_list
    |> Enum.uniq
  end


  @doc """

  """
  def league(id) do
    SoccerParser.stream()
    |> Flow.map(fn row -> [Enum.at(row, 1), Enum.at(row, 2)] end)
    |> Flow.filter(fn row -> List.first(row) == id end)
    |> Flow.map(fn row -> Enum.at(row, 1) end)
    |> Enum.to_list
    |> Enum.uniq
  end



  @doc """

  """
  def league(id, session) do
    SoccerParser.stream()
    |> Flow.filter(fn row -> Enum.at(row,1) == id && Enum.at(row,2) == session end)
    |> Enum.to_list
    |> Enum.uniq
  end

end
