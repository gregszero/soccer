defmodule GameData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          league: String.t(),
          season: String.t(),
          games: [GameData.Games.t()]
        }
  defstruct [:league, :season, :games]

  field :league, 1, type: :string
  field :season, 2, type: :string
  field :games, 3, repeated: true, type: GameData.Games
end

defmodule GameData.Games do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          date: String.t(),
          home_team: String.t(),
          away_team: String.t(),
          fth: String.t(),
          ftag: String.t(),
          ftr: String.t(),
          hthg: String.t(),
          htag: String.t(),
          htr: String.t()
        }
  defstruct [:id, :date, :home_team, :away_team, :fth, :ftag, :ftr, :hthg, :htag, :htr]

  field :id, 1, type: :string
  field :date, 2, type: :string
  field :home_team, 3, type: :string
  field :away_team, 4, type: :string
  field :fth, 5, type: :string
  field :ftag, 6, type: :string
  field :ftr, 7, type: :string
  field :hthg, 8, type: :string
  field :htag, 9, type: :string
  field :htr, 10, type: :string
end
