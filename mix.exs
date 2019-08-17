defmodule Soccer.MixProject do
  use Mix.Project

  def project do
    [
      app: :soccer,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Soccer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:flow, "~> 0.14"},
      {:nimble_csv, "~> 0.3"},
      {:protobuf, "~> 0.5.3"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
    ]
  end
end
