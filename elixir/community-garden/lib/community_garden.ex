# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {[], 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {regs, _counter} -> regs end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {regs, counter} -> 
      new_plot = %Plot{plot_id: counter + 1, registered_to: register_to}
      { new_plot, {[new_plot| regs], counter + 1} } end)
  end

  def release(pid, plot_id) do
    delete_filter = fn plot -> plot.plot_id != plot_id end
    Agent.update(pid, fn {regs, counter} -> {Enum.filter(regs, delete_filter), counter} end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {regs, _} -> Enum.find(regs, {:not_found, "plot is unregistered"} , &(&1.plot_id == plot_id)) end)
  end
end
