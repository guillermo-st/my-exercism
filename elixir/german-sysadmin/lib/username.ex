defmodule Username do

  def sanitize(username) do
    sanitizer = fn char -> 
      case char do
        ?ä -> [?a, ?e]
        ?ö -> [?o, ?e]
        ?ü -> [?u, ?e]
        ?ß -> [?s, ?s]
        c when c in ?a .. ?z or c == ?_ -> [char]
        _ -> []
      end
    end

    username |> Enum.flat_map(sanitizer) 
  end
end
