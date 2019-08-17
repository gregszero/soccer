defmodule Soccer do
  @moduledoc """
  Documentation for Soccer.
  Provides methods for retrieve leagues, sessions and match data
  """

  @doc """
  Use SoccerParser to retrieve a Stream, then maps the needed attributes, filter uniques and return all Leagues

  ## Parameters

  ## Examples
  iex> Soccer.leagues()

  """
  def leagues do
    SoccerParser.stream()
    |> Flow.map(fn row -> Enum.at(row, 1) end)
    |> Enum.to_list
    |> Enum.uniq
  end


  @doc """
  Use SoccerParser to retrieve a Stream, then maps the needed attributes, filter leagues that has the same id
  and return all Seasons from the given League

  ## Parameters
  - id: String that represents the identifier of the league

  ## Examples
  iex> Soccer.leagues("SP1")

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
  Use SoccerParser to retrieve a Stream, then maps the needed attributes, filter rows by League and Season then
  return all records found

  ## Parameters
  - id: String that represents the identifier of the league
  - season: String that represents the identifier of the Season

  ## Examples
  iex> Soccer.leagues("SP1", "201617")
  """
  def league(id, season) do
    SoccerParser.stream()
    |> Flow.filter(fn row -> Enum.at(row,1) == id && Enum.at(row,2) == season end)
    |> Enum.to_list
    |> Enum.uniq
  end

end
