defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("gif"), do: "image/gif"
  def type_from_extension(_), do: nil


  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7f, 0x45, 0x4C, 0x46, _body::binary>> -> type_from_extension("exe")
      <<0x42, 0x4D, _body::binary>> -> type_from_extension("bmp")
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _body::binary>> -> type_from_extension("png")
      <<0xFF, 0xD8, 0xFF, _body::binary>> -> type_from_extension("jpg")
      <<0x47, 0x49, 0x46, _body::binary>> -> type_from_extension("gif")
      _ -> nil
    end
  end

  def verify(file_binary, extension) do  
    binary_type = type_from_binary(file_binary)
    ext_type = type_from_extension(extension)

    case {binary_type, ext_type} do
      {nil, _} -> {:error, "Warning, file format and file extension do not match."}
      {t, t} -> {:ok, t}
      {_, _} -> {:error, "Warning, file format and file extension do not match."}
    end
  end

end
