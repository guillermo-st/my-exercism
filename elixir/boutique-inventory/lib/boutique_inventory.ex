defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    item_updater = fn item -> %{item | name: String.replace(item[:name], old_word, new_word)} end
    Enum.map(inventory, item_updater)
  end

  def increase_quantity(item, count) do
    quantity_increaser = fn {size, q} -> {size, q + count} end
    quantity_updater = fn quantities -> 
      Enum.into(quantities, %{}, quantity_increaser) 
    end   
    Map.update!(item, :quantity_by_size, quantity_updater)
  end

  def total_quantity(item) do
    quantity_counter = fn {_size, q}, count -> count + q end
    Enum.reduce(item[:quantity_by_size], 0, quantity_counter)
  end
end
