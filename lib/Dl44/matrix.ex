defmodule Dl44.Matrix do
  require Integer
  alias Dl44.Matrix

  # TODO Clean up this module's organization

  def new(input) when is_tuple(input) do
    Tuple.to_list(input)
    |> Enum.map(&List.wrap/1)
    |> Matrix.new
  end
  def new(input), do: Matrex.new(input)

  def round(m = %Matrex{}), do: Matrix.round(m, 5)
  def round(m = %Matrex{}, precision) do
    Matrex.apply(m, fn val -> Float.round(val, precision) end)
  end

  def loose_equal?(m1, m2) do
    Matrix.round(m1) == Matrix.round(m2)
  end

  def multiply(m = %Matrex{}, t) when is_tuple(t) do
    m
    |>Matrex.dot(Matrix.new(t))
    |> Matrex.to_list
    |> List.to_tuple
  end
  def multiply(i1, i2), do: Matrex.dot(i1, i2)

  def identity(input), do: Matrex.identity(input)

  def transpose(input), do: Matrex.transpose(input)

  def at(m, r, c), do: Matrex.at(m, r+1, c+1)
  def set(m, r, c, val), do: Matrex.set(m, r+1, c+1, val)

  def inverse(m) do
    if !invertible?(m), do: raise ArgumentError, message: "given matrix is not invertible"

    d = Matrix.determinant(m)
    {row, col} = Matrex.size(m)

    for i <- 0..row-1, j <- 0..col-1, reduce: Matrex.zeros(row, col) do
      acc ->
        c = Matrix.cofactor(m, i, j)
        Matrix.set(acc, i, j, (c / d))
      end
      |> Matrix.transpose
  end

  def submatrix(m, r, c) do
    m
    |> Matrex.to_list_of_lists
    |> Enum.map(fn row -> List.delete_at(row, c) end)
    |> List.delete_at(r)
    |> Matrix.new
  end

  def determinant(m) do
    det(m, Matrex.size(m))
  end

  defp det(m, {2, 2}) do
    a = Matrix.at(m, 0, 0)
    b = Matrix.at(m, 1, 0)
    c = Matrix.at(m, 0, 1)
    d = Matrix.at(m, 1, 1)

    (a*d) - (b*c)
  end
  defp det(m, _) do
    m
    |> Matrex.to_list_of_lists
    |> hd
    |> Enum.map_reduce(0, fn x, index ->
      {(x * Matrix.cofactor(m, 0, index)), index+1}
    end)
    |> elem(0)
    |> Enum.sum
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

  def invertible?(m) do
    Matrix.determinant(m) != 0
  end
end
