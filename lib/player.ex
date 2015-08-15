defmodule Player do
  defstruct fold_most_tiles: :random.uniform,
            fold_lower_values: :random.uniform

  def play(%{state: :ok} = game, player) do
    dices = Game.rand
    possible_plays = Game.possible_plays(game, dices)

    game = if Enum.count(possible_plays) == 0 do
      Game.finish(game)
    else
      sort_fn = if :random.uniform < player.fold_lower_values do
        fn {a1, a2}, {b1, b2} ->
          (a1 + a2) <= (b1 + b2)
        end
      else
        fn {a1, a2}, {b1, b2} ->
          (a1 + a2) >= (b1 + b2)
        end
      end

      possible_plays = Enum.sort(possible_plays, sort_fn)
      
      play = List.first(possible_plays)
      
      Game.fold_tiles(game, play)
    end
    
    play(game, player)
  end

  def play(%{state: :ended} = game, player) do
    game
  end
end
