defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  defp extract_message(_, []), do: ""
  defp extract_message(_, nil), do: ""
  defp extract_message(func_name, args) do
    n = length(args) - 1
    func_name |> Kernel.to_string |> String.slice(0..n)
  end

  def decode_secret_message_part(ast = {op, _, [{:when, _, [{func_name, _, args} | _]} | _]}, acc) when op in [:def, :defp] do
    {ast, [extract_message(func_name, args) | acc]}
  end

  def decode_secret_message_part(ast = {op, _, [{func_name, _, args} | _]}, acc) when op in [:def, :defp] do
    {ast, [extract_message(func_name, args) | acc]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_, reverse_decoded} = string |> to_ast |> Macro.prewalk([], &decode_secret_message_part/2) 
    reverse_decoded |> Enum.reverse |> List.to_string
  end
end
