defmodule DataEncoder do
  @moduledoc """
  Documentation for DataEncoder
  Encode received data into JSON or Protobuf
  """


  def encode_league(data) do
    Poison.encode!(%{leagues: data})
  end

  def encode_seasons(data) do
    Poison.encode!(%{seasons: data})
  end

  def encode_games(data, id, season_id) do
    Poison.encode!(%{
      league: id,
      season: season_id,
      games: data
             |> Enum.map(fn game -> %{
                                      id: Enum.at(game, 0),
                                      date: Enum.at(game, 3),
                                      home_team: Enum.at(game, 4),
                                      away_team: Enum.at(game, 5),
                                      fthg: Enum.at(game, 6),
                                      ftag: Enum.at(game, 7),
                                      ftr: Enum.at(game, 8),
                                      hthg: Enum.at(game, 9),
                                      htag: Enum.at(game, 10),
                                      htr: Enum.at(game, 11)
                                    } end)
    })
  end

  def encode_proto(data, id, season_id) do
    game_data = GameData.new(
      league: id,
      season: season_id,
      games:
        data
        |>Enum.map(fn game ->
          GameData.Games.new(
            id: Enum.at(game, 0),
            date: Enum.at(game, 3),
            home_team: Enum.at(game, 4),
            away_team: Enum.at(game, 5),
            fthg: Enum.at(game, 6),
            ftag: Enum.at(game, 7),
            ftr: Enum.at(game, 8),
            hthg: Enum.at(game, 9),
            htag: Enum.at(game, 10),
            htr: Enum.at(game, 11))
        end)
    )
    GameData.encode(game_data)
  end
end
