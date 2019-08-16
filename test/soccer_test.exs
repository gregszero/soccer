defmodule SoccerTest do
  use ExUnit.Case
  doctest Soccer

  test "greets the world" do
    assert Soccer.hello() == :world
  end
end
