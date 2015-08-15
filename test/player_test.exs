defmodule PlayerTest do
  use ExUnit.Case

  test "play should play until the game is finished" do
    game = Player.play(%Game{}, %Player{})
    assert game.state == :ended
  end
  
  test "play an ended game should leave the game ended" do
    game = %Game{state: :ended}
    assert Player.play(game, %Player{}) == game
  end
end
