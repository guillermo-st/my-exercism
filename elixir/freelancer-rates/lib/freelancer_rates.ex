defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount/100 * discount)
  end

  def monthly_rate(hourly_rate, discount) do
    rate = apply_discount(22 * daily_rate(hourly_rate), discount)
    Float.ceil(rate) |> Kernel.trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discount_daily_rate = daily_rate(hourly_rate) |> apply_discount(discount)
    budget/discount_daily_rate |> Float.floor(1)
  end
end
