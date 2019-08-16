defmodule Soccer.Router do
  use Plug.Router
  use Plug.ErrorHandler

  # Placing parser after match to parse only after a
  # route match
  plug :match
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
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
    send_resp(conn, 200, Soccer.leagues())
  end

  @doc """
  GET /league/:id
  Receive league id and returns a list of all season from this league

  ## Parameters

    - id: String that represents the identifier of the league

  ## Examples

  """
  get "/league/:id" do
    send_resp(conn, 200, Soccer.league(id))
  end



  # Receive league id and season id
  #
  @doc """
  GET /league/:id/season/:season_id
  Returns a list of all results from this league and season

  ## Parameters

    - id: String that represents the identifier of the league
    - season_id: String that represents the identifier of the Season
  ## Examples

  """
  get "/league/:id/season/:season_id" do
    send_resp(conn, 200, Soccer.league(id,season_id))
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
