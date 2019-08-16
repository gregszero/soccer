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

  #GET /league
  #Returns a list of all leagues
  get "/league" do
    send_resp(conn, 200, Soccer.leagues())
  end


  # GET /league/:id
  # Receive league id and returns a list of all sessions from this league
  get "/league/:id" do
    send_resp(conn, 200, Soccer.league(id))
  end


  #  GET /league/:id/session/:sess_id
  # Receive league id and session id
  # Returns a list of all results from this league and session
  get "/league/:id/session/:sess_id" do
    send_resp(conn, 200, Soccer.league(id,sess_id))
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
