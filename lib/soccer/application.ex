defmodule Soccer.Application do
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Soccer.Router, options: [port: cowboy_port()]}
    ]

    opts = [strategy: :one_for_one, name: Soccer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:soccer, :cowboy_port, 8080)

end
