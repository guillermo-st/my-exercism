defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    Enum.to_list(rank_range())
  end

  def files do
    codepoint_converter = fn c -> <<c::utf8>> end
    file_range() |> Enum.map(codepoint_converter)
  end
end
