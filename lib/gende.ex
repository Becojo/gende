defmodule Gende do

  def main do
    n = 1000
    scores = for i <- 1..n do
      Player.play(%Game{}, %Player{}).score
    end

    scores = Enum.sort(scores)
    avg = Enum.sum(scores) / n
    
    IO.puts "n = #{n}"
    IO.puts "avg = #{avg}"

    for x <- 0..10 do
      p = x / 10
      q = quantile(scores, p)
      
      IO.puts "q(#{p}) = #{q}"
    end

    nil
  end

  def quantile(x, q) do
    n = (Enum.count(x) - 1) * q
    f = round(n)

    Enum.at(x, f)
  end
    
end
