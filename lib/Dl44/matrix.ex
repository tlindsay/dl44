defmodule Dl44.Matrix do
  require Integer
  alias Dl44.Matrix

  def new(input) when is_tuple(input) do
    Tuple.to_list(input)
    |> Enum.map(&List.wrap/1)
    |> Matrix.new
  end
  def new(input), do: Matrex.new(input)

  def multiply(m = %Matrex{}, t) when is_tuple(t) do
    m
    |>Matrex.dot(Matrix.new(t))
    |> Matrex.to_list
    |> List.to_tuple
  end
  def multiply(i1, i2), do: Matrex.multiply(i1, i2)

  def identity(input), do: Matrex.identity(input)

  def transpose(input), do: Matrex.transpose(input)

  def at(m, r, c), do: Matrex.at(m, r+1, c+1)

  # def inverse(m) do

  # end

  # def cofactor do

  # end

  def submatrix(m, r, c) do
    m
    |> Matrex.to_list_of_lists
    |> Enum.map(fn row -> List.delete_at(row, c) end)
    |> List.delete_at(r)
    |> Matrix.new
  end

  def determinant(m) do
    if (Matrex.size(m) == {2, 2}) do
      a = Matrix.at(m, 0, 0)
      b = Matrix.at(m, 1, 0)
      c = Matrix.at(m, 0, 1)
      d = Matrix.at(m, 1, 1)

      (a*d) - (b*c)
    end
  end

  def minor(m, row, col) do
    m
    |> Matrix.submatrix(row, col)
    |> Matrix.determinant
  end

  def cofactor(m, row, col) when Integer.is_even(row+col), do: minor(m, row, col)
  def cofactor(m, row, col) do
    minor(m, row, col) * -1
  end
end
