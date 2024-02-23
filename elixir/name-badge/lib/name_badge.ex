defmodule NameBadge do

  defp format_department(nil), do: "OWNER"
  defp format_department(dep), do: String.upcase(dep)
  

  def print(id, name, department) do

    if !id do
      "#{name} - #{format_department(department)}"
    else
      "[#{id}] - #{name} - #{format_department(department)}"
    end

  end
end