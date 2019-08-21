defmodule SoccerParser do
  @moduledoc """
  Documentation for SoccerParser.
  Provides stream to read CSV Data
  """

  NimbleCSV.define(ScParser, separator: "\,", escape: "\"")

  @doc """
    Uses Nimble CSV to parse FileStream.
    Uses Flow to execute computations in parallel using multiple GenStages
  """
  def stream do
    "./resources/Data.csv"
    |> File.stream!
    |> ScParser.parse_stream
    |> Flow.from_enumerable()
  end

end
