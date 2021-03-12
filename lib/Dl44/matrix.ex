defmodule Dl44.Matrix do
  alias Dl44.Matrix

  def new(input), do: Matrex.new(input)

  def multiply(m = %Matrex{}, t) when is_tuple(t) do
    tup = Tuple.to_list(t)
          |> Enum.map(&List.wrap/1)
          |> Matrix.new

    Matrex.dot(m, tup)
    |> Matrex.to_list
    |> List.to_tuple
  end
  def multiply(i1, i2), do: Matrex.multiply(i1, i2)
end
