defmodule BasketballWebsite do

  defp do_extract(nil, _), do: nil
  defp do_extract(data, []), do: data
  defp do_extract(data, [next_path | rest]) do
    do_extract(data[next_path], rest)
  end

  def extract_from_path(data, path) do
    subpaths = String.split(path, ".")
    do_extract(data, subpaths)
  end

  def get_in_path(data, path) do
    subpaths = String.split(path, ".")
    Kernel.get_in(data, subpaths)
  end
end
