defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, qty} = volume_pair
    qty
  end

  def to_milliliter({:milliliter, qty}), do: {:milliliter, qty}
  def to_milliliter({:cup, qty}), do: {:milliliter, qty * 240}
  def to_milliliter({:fluid_ounce, qty}), do: {:milliliter, qty * 30}
  def to_milliliter({:teaspoon, qty}), do: {:milliliter, qty * 5}
  def to_milliliter({:tablespoon, qty}), do: {:milliliter, qty * 15}

  def from_milliliter(volume_pair, unit) do
    {_, unit_ml} = to_milliliter({unit, 1})
    {_, ml} = volume_pair
    {unit, ml/unit_ml}
  end

  def convert(volume_pair, unit) do
    {_, from_unit_ml} = to_milliliter(volume_pair)
    {_, to_unit_ml} = to_milliliter({unit, 1})
    {unit, Kernel.trunc(from_unit_ml/to_unit_ml)}
  end
end
