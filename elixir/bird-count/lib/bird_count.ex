defmodule BirdCount do

  def today([h|_t]) do
    h
  end

  def today([]) do
    nil
  end

  def increment_day_count([h|t]) do
    [h + 1 | t]
  end

  def increment_day_count([]) do
    [1]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([h|_t]) when h == 0, do: true
  def has_day_without_birds?([_h | t]), do: has_day_without_birds?(t)


  def total([]) do
    0
  end

  def total([h|t]) do
    h + total(t)
  end

  def busy_days([]), do: 0
  def busy_days([h | t]) when h > 4, do: 1 + busy_days(t)
  def busy_days([_ | t]), do: busy_days(t)

end
