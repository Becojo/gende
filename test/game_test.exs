defmodule GameTest do
  use ExUnit.Case
  
  test "decompose pairs should add up to n" do
    for n <- 1..12 do
      for {a, b} <- Game.decompose(n) do
        assert a + b == n
      end
    end
  end

  test "can_fold? 0" do
    for i <- 1..12 do
      assert Game.can_fold?(%Game{}, {0, i})
      assert Game.can_fold?(%Game{}, {i, 0})
    end
  end

  test "can_fold? all tiles in a new game" do
    game = %Game{}
    
    for i <- 1..12 do
      for j <- 1..12 do
        assert Game.can_fold?(game, {i, j})
      end
    end
  end

  test "fold_tiles" do
    for i <- 1..12 do
      for j <- 1..12 do
        game = Game.fold_tiles(%Game{}, {i, j})

        assert !Set.member?(game.tiles, i)
        assert !Set.member?(game.tiles, j)
      end
    end
  end
end
