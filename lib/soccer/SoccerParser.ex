defmodule SoccerParser do
  NimbleCSV.define(MyParser, separator: "\,", escape: "\"")

  def stream do
    "./resources/Data.csv"
    |> File.stream!
    |> MyParser.parse_stream
    |> Flow.from_enumerable()
  end

end
