Benchee.run(
  %{
    :leagues => fn -> Soccer.leagues end,
    :league_season => fn -> Soccer.league("SP1") end,
    :games => fn -> Soccer.league("SP1", "201617") end
  },
  formatters: [
    {Benchee.Formatters.HTML, file: "benchmark_output/soccer.html"},
    Benchee.Formatters.Console
  ]
)
