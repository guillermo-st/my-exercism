defmodule DNA do

  @encoded_acid_bitsize 4

  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(?\s), do: 0b0000

  def decode_nucleotide(0b0000), do: ?\s 
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  
  defp do_encode([], encoding), do: encoding
  defp do_encode([acid | rest], encoding) do
    encoded_acid = encode_nucleotide(acid)
    do_encode(rest, <<encoding::bitstring, encoded_acid::@encoded_acid_bitsize>>)
  end

  def encode(dna), do: do_encode(dna, <<>>)

  #helper function to reverse the list of decoded dna
  defp do_reverse_dna([], reversed_dna), do: reversed_dna
  defp do_reverse_dna([h | t], reversed), do: do_reverse_dna(t, [h | reversed])
  defp reverse_dna(dna) do
    do_reverse_dna(dna, [])
  end

  defp do_decode(<<>>, dna), do: reverse_dna(dna)
  defp do_decode(encoded_dna, dna) do
    <<acid::@encoded_acid_bitsize, rest::bitstring>> = encoded_dna
    decoded_acid = decode_nucleotide(acid)
    do_decode(rest, [decoded_acid | dna])
  end

  def decode(encoded_dna), do: do_decode(encoded_dna, [])



end
