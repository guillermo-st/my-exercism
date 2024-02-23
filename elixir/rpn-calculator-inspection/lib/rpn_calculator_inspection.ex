defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    calc = fn -> calculator.(input) end
    %{pid: spawn_link(calc), input: input}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(_calculator, []), do: %{}
  def reliability_check(calculator, inputs) do
    prev_trap_val = Process.flag(:trap_exit, true)

    starter = fn input -> start_reliability_check(calculator, input) end
    awaiter = fn input -> await_reliability_check_result(input, %{}) end

    results = inputs |> Enum.map(starter) |> Enum.map(awaiter) |> Enum.reduce(&Map.merge/2) 
    Process.flag(:trap_exit, prev_trap_val)
    results
  end

  defp async_calc(calculator, input) do
    calc = fn -> calculator.(input) end
    Task.async(calc)
  end

  def correctness_check(calculator, inputs) do
    inputs |> Enum.map(&async_calc(calculator, &1)) |> Enum.map(&(Task.await(&1, 100)))
  end
end
