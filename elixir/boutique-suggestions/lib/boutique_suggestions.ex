defmodule BoutiqueSuggestions do

  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.00)

    for t = %{base_color: top_color, price: top_price} <- tops,
      b = %{base_color: bot_color, price: bot_price} <- bottoms, 
      top_color != bot_color,
      top_price + bot_price <= max_price do
      {t, b}
    end
  end

end
