defmodule TakeANumber do

  defp receive_loop(num) do
    receive do
      {:report_state, sender_pid} -> 
        send(sender_pid, num)  
        receive_loop(num)
      {:take_a_number, sender_pid} ->
        send(sender_pid, num + 1)
        receive_loop(num + 1)
      :stop -> nil
      _ -> receive_loop(num)
    end
  end


  def start() do
    receiver = fn -> receive_loop(0) 
      end
    spawn(receiver)
  end
end
