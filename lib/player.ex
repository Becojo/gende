defmodule Player do
  defstruct fold_most_tiles: :random.uniform,
            fold_lower_values: :random.uniform

  def play(%{state: :ok} = game, player) do
    dices = Game.rand
    possible_plays = Enum.sort(Game.possible_plays(game, dices))

    game = if Enum.count(possible_plays) == 0 do
      Game.finish(game)
    else
      Game.fold_tiles(game, List.first(possible_plays)) 
    end
    
    play(game, player)
  end

  def play(%{state: :ended} = game, _) do
    game
  end
end
