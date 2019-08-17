defmodule Soccer.Router do
  use Plug.Router
  use Plug.ErrorHandler

  # Placing parser after match to parse only after a
  # route match
  plug(Plug.Logger)
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hi!")
  end

  @doc """
  GET /league
  Returns a list of all leagues

  ## Parameters
  ## Examples

  """
  get "/league" do
    leagues = Soccer.leagues()
    send_resp(conn, 200, encode_league(leagues))
  end

  @doc """
  GET /league/:id
  Receive league id and returns a list of all season from this league

  ## Parameters

    - id: String that represents the identifier of the league

  ## Examples

  """
  get "/league/:id" do
    seasons = Soccer.league(id)
    send_resp(conn, 200, encode_seasons(seasons))
  end


  @doc """
  GET /league/:id/season/:season_id
  Returns a list of all results from this league and season

  ## Parameters

    - id: String that represents the identifier of the league
    - season_id: String that represents the identifier of the Season
  ## Examples

  """
  get "/league/:id/season/:season_id" do
    games = Soccer.league(id, season_id)
    send_resp(conn, 200, encode_games(games, id, season_id))
  end

  get "proto/league/:id/season/:season_id" do
    games = Soccer.league(id, season_id)
    conn
    |> put_resp_header("content-type", "application/octet-stream")
    |> send_resp(200, encode_proto(games, id, season_id))
  end

  match _ do
    send_resp(conn, 404, "Page not found!")
  end

  ## Handling errors
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end

  defp encode_league(data) do
    Poison.encode!(%{leagues: data})
  end

  defp encode_seasons(data) do
    Poison.encode!(%{seasons: data})
  end

  defp encode_games(data, id, season_id) do
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

  defp encode_proto(data, id, season_id) do
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
