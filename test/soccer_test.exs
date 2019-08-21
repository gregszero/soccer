defmodule SoccerTest do
  use ExUnit.Case
  doctest Soccer

  test "return all leagues" do
    assert Soccer.leagues == ["SP1", "SP2", "E0", "D1"]
  end
end
