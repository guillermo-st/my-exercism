defmodule Newsletter do
  def read_emails(path) do
    path |> File.read! |> String.split("\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  defp send_emails([], log, _), do: close_log(log)
  defp send_emails([next_email | rest], log, send_fun) do
    if send_fun.(next_email) == :ok do
      log_sent_email(log, next_email)
    end

    send_emails(rest, log, send_fun)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log = open_log(log_path)
    send_emails(emails, log, send_fun)
  end
end
