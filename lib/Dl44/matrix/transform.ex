defmodule Dl44.Matrix.Transform do
  alias Dl44.Matrix
  alias Dl44.Point
  alias Dl44.Vector

  def translate(_t, v = %Vector{}), do: v
  def translate(t = {_x, _y, _z}, p = %Point{}) do
    translationMatrix(t)
    |> translate(p)
  end
  def translate(t = %Matrex{}, p = %Point{}) do
    p = Point.to_mat(p)

    t
    |> Matrix.multiply(p)
  end

  @doc """
  A translation matrix takes the form:
    [[ 1.0, 0.0, 0.0, x   ],
     [ 0.0, 1.0, 0.0, y   ],
     [ 0.0, 0.0, 1.0, z   ],
     [ 0.0, 0.0, 0.0, 1.0 ]]
  """
  def translationMatrix({x, y, z}) do
    Matrix.identity(4)
    |> Matrix.set(0, 3, x)
    |> Matrix.set(1, 3, y)
    |> Matrix.set(2, 3, z)
  end
end
