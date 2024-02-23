defmodule LibraryFees do

  @monday 1
  @noon ~T[12:00:00]

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime |> NaiveDateTime.to_time |> Time.before?(@noon)
  end

  def return_date(checkout_datetime) do
    checkout_date = NaiveDateTime.to_date(checkout_datetime)
    cond do
      before_noon?(checkout_datetime) -> checkout_date|> Date.add(28)
      true -> checkout_date |> Date.add(29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime 
    |> NaiveDateTime.to_date 
    |> Date.diff(planned_return_date) 
    |> Kernel.max(0)
  end

  def monday?(datetime) do
    day_of_week = datetime |> NaiveDateTime.to_date |> Date.day_of_week
    day_of_week == @monday
  end

  def calculate_late_fee(checkout, return, rate) do
    check_datetime = datetime_from_string(checkout)
    actual_return = datetime_from_string(return)
    planned_return = return_date(check_datetime)
    
    cond do
      monday?(actual_return) -> 0.5 * rate * days_late(planned_return, actual_return) |> Kernel.trunc()
      true -> rate * days_late(planned_return, actual_return)
    end
  end

end
