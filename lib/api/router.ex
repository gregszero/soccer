defmodule Soccer.Router do
  @moduledoc """
  Documentation for Soccer.Router
  Defines rest routes
  """

  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)
  plug :match
  plug :dispatch

  @doc """
  GET /league
  Returns a list of all leagues

  ## Parameters
  ## Examples

  """
  get "/league" do
    leagues = Soccer.leagues()
    send_resp(conn, 200, DataEncoder.encode_league(leagues))
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
    send_resp(conn, 200, DataEncoder.encode_seasons(seasons))
  end


  @doc """
  GET /league/:id/season/:season_id
  Returns a list of all results from this league and season in JSON

  ## Parameters

    - id: String that represents the identifier of the league
    - season_id: String that represents the identifier of the Season
  ## Examples

  """
  get "/league/:id/season/:season_id" do
    games = Soccer.league(id, season_id)
    send_resp(conn, 200, DataEncoder.encode_games(games, id, season_id))
  end

  @doc """
  GET /proto/league/:id/season/:season_id
  Returns a list of all results from this league and season in Proto

  ## Parameters

    - id: String that represents the identifier of the league
    - season_id: String that represents the identifier of the Season
  ## Examples

  """
  get "proto/league/:id/season/:season_id" do
    games = Soccer.league(id, season_id)
    conn
    |> put_resp_header("content-type", "application/octet-stream")
    |> send_resp(200, DataEncoder.encode_proto(games, id, season_id))
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

end
