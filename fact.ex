defmodule Fact do


  @doc """

  calculates the factorial of the incoming number
  via the ordinary way

  ## Example

      iex> number = 5 
      iex> Fact.fact(number)
      120
  
  """

  def fact(0) do
    1
  end

  def fact(number) do
    number * fact(number-1)
  end
  
end
