defmodule Game do
  defstruct tiles: Enum.into(1..12, HashSet.new), state: :ok, score: nil

  @spec decompose(integer) :: [{integer, integer}]
  @doc """
  Decompose an integer n into pairs of integer a, b such that a + b = n
  where a < b and a >= 0 and b <= 12

  ## Example
      iex> Game.decompose(6)
      [[2, 4], [1, 5], [0, 6]]
  """
  def decompose(n) do
    for x <- div(n, 2)..n, x > n / 2, do: {n - x, x}
  end

  @spec fold_tiles(%Game{}, {integer, integer}) :: %Game{}
  def fold_tiles(game, {a, b} = play) do
    if can_fold?(game, play) do
      %{game | tiles: game.tiles |> Set.delete(a) |> Set.delete(b)}
    else
      game
    end
  end

  @spec rand() :: integer
  @doc """
  Return the result of throwing two dices
  """
  def rand do
    :random.uniform(6) + :random.uniform(6)
  end


  @spec can_fold?(%Game{}, {integer, integer}) :: boolean
  @doc """
  
  """
  def can_fold?(game, {a, b}) do
    (a == 0 or Set.member?(game.tiles, a)) and
    (b == 0 or Set.member?(game.tiles, b))
  end

  @spec possible_plays(%Game{}, integer) :: [{integer, integer}]
  @doc """
  List possible plays for a given number given the current state of the game
  """
  def possible_plays(game, n) do
    decompose(n) |> Enum.filter(&(can_fold?(game, &1)))
  end

  @spec finish(%Game{}) :: %Game{}
  @doc """
  Finish a game. Change the state to ended and calculate the score.
  """
  def finish(game) do
    %{game | state: :ended, score: Enum.sum(game.tiles)}
  end
end

defimpl Inspect, for: Game do
  def inspect(dict, opts) do
    tiles = Enum.join(for tile <- 1..12 do
      if Set.member?(dict.tiles, tile) do
        Integer.to_string(tile)
      else
        "_"
      end
    end, ",")
    
    "%Game{tiles: #{tiles}, state: #{dict.state}, score: #{dict.score}}"
  end
end
