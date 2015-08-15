defmodule Player do
  defstruct fold_most_tiles: :random.uniform,
            fold_lower_values: :random.uniform

  def play(%{state: :ok} = game, player) do
    dices = Game.rand
    possible_plays = Game.possible_plays(game, dices)

    game = if Enum.count(possible_plays) == 0 do
      Game.finish(game)
    else
      play = List.first(possible_plays)
      
      Game.fold_tiles(game, play)
    end
    
    play(game, player)
  end

  def play(%{state: :ended} = game, player) do
    game
  end
end
