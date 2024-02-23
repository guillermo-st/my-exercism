defmodule PaintByNumber do
  def palette_bit_size(1), do: 1
  def palette_bit_size(color_count), do: color_count |> :math.log2 |> Kernel.ceil

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    color_size = palette_bit_size(color_count)
    <<pixel_color_index::size(color_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count)  do
    color_size = palette_bit_size(color_count)
    <<pixel::size(color_size), _rest::bitstring>> = picture
    pixel
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    color_size = palette_bit_size(color_count)
    <<_pixel::size(color_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
