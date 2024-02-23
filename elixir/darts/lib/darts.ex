defmodule Darts do
  @type position :: {number, number}

  defp distance_to_center({x, y}) do
    (x*x + y*y)**0.5
  end

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    d = distance_to_center({x, y})
    cond do
      d > 10 -> 0
      d > 5 -> 1
      d > 1 -> 5
      true -> 10
    end
  end
end
