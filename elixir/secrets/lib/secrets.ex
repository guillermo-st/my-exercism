defmodule Secrets do
  def secret_add(secret) do
    adder = fn val -> 
      secret + val
    end

    adder
  end

  def secret_subtract(secret) do
    sub = fn val ->
      val - secret
    end

    sub
  end

  def secret_multiply(secret) do
    multiplier = fn val ->
      val * secret
    end

    multiplier
  end

  def secret_divide(secret) do
    divider = fn val ->
      val / secret |> Kernel.trunc()
    end

    divider
  end

  def secret_and(secret) do
    bw_and = fn val -> 
      Bitwise.band(val, secret)
    end

    bw_and
  end

  def secret_xor(secret) do
    bw_xor = fn val -> 
      Bitwise.bxor(val, secret)
    end

    bw_xor
  end

  def secret_combine(secret_function1, secret_function2) do
    combiner = fn val ->
      secret_function2.(secret_function1.(val))
    end

    combiner
  end

end
