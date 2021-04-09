defmodule Dl44.Matrix.Transform do
  alias Dl44.Matrix
  alias Dl44.Point
  alias Dl44.Vector

  def rotate(p = %Point{}, angle, axis),  do: Point.to_mat(p) |> rotate(angle, axis)
  def rotate(v = %Vector{}, angle, axis), do: Vector.to_mat(v) |> rotate(angle, axis)
  def rotate(mat = %Matrex{}, angle, :x), do: rotation_x(angle) |> Matrix.multiply(mat)
  def rotate(mat = %Matrex{}, angle, :y), do: rotation_y(angle) |> Matrix.multiply(mat)
  def rotate(mat = %Matrex{}, angle, :z), do: rotation_z(angle) |> Matrix.multiply(mat)


  def scale(p = %Point{}, t), do: Point.to_mat(p) |> scale(t)
  def scale(v = %Vector{}, t), do: Vector.to_mat(v) |> scale(t)
  def scale(m1 = %Matrex{}, m2 = %Matrex{}), do: Matrix.multiply(m2, m1)
  def scale(mat = %Matrex{}, t = {_x, _y, _z}) do
    t
    |> scalingMatrix
    |> Matrix.multiply(mat)
  end

  def shear(p = %Point{}, t), do: Point.to_mat(p) |> shear(t)
  def shear(v = %Vector{}, t), do: Vector.to_mat(v) |> shear(t)
  def shear(mat = %Matrex{}, t) do
    t
    |> shearingMatrix
    |> Matrix.multiply(mat)
  end

  def translate(p = %Point{}, t),  do: Point.to_mat(p) |> translate(t)
  def translate(v = %Vector{}, _), do: Vector.to_mat(v)
  def translate(m1 = %Matrex{}, m2 = %Matrex{}), do: Matrix.multiply(m2, m1)
  def translate(mat = %Matrex{}, t = {_x, _y, _z}) do
    t
    |> translationMatrix
    |> Matrix.multiply(mat)
  end

  @doc """
  A rotation X matrix takes the form:
    [[ 0.0,    0.0,     0.0, 0.0 ],
     [ 0.0, cos(r), -sin(r), 0.0 ],
     [ 0.0, sin(r),  cos(r), 0.0 ],
     [ 0.0,    0.0,     0.0, 1.0 ]]
  """
  def rotation_x(r) do
    [[ 0.0,          0.0,           0.0, 0.0 ],
     [ 0.0, :math.cos(r), -:math.sin(r), 0.0 ],
     [ 0.0, :math.sin(r),  :math.cos(r), 0.0 ],
     [ 0.0,          0.0,           0.0, 1.0 ]]
     |> Matrex.new
  end

  @doc """
  A rotation Y matrix takes the form:
    [[  cos(r), 0.0, sin(r), 0.0 ],
     [     0.0, 1.0,    0.0, 0.0 ],
     [ -sin(r), 0.0, cos(r), 0.0 ],
     [     0.0, 0.0,    0.0, 1.0 ]]
  """
  def rotation_y(r) do
    [[  :math.cos(r), 0.0, :math.sin(r), 0.0 ],
     [     0.0, 1.0,    0.0, 0.0 ],
     [ -:math.sin(r), 0.0, :math.cos(r), 0.0 ],
     [     0.0, 0.0,    0.0, 1.0 ]]
     |> Matrex.new
  end

  @doc """
  A rotation Z matrix takes the form:
    [[ cos(r), -sin(r), 0.0, 0.0 ],
     [ sin(r),  cos(r), 0.0, 0.0 ],
     [    0.0,     0.0, 1.0, 0.0 ],
     [    0.0,     0.0, 0.0, 1.0 ]]
  """
  def rotation_z(r) do
    [[ :math.cos(r), -:math.sin(r), 0.0, 0.0 ],
     [ :math.sin(r),  :math.cos(r), 0.0, 0.0 ],
     [    0.0,     0.0, 1.0, 0.0 ],
     [    0.0,     0.0, 0.0, 1.0 ]]
     |> Matrex.new
  end

  @doc """
  A scaling matrix takes the form:
    [[   x, 0.0, 0.0, 0.0 ],
     [ 0.0,   y, 0.0, 0.0 ],
     [ 0.0, 0.0,   z, 0.0 ],
     [ 0.0, 0.0, 0.0, 1.0 ]]
  """
  def scalingMatrix({x, y, z}) do
    Matrix.identity(4)
    |> Matrix.set(0, 0, x)
    |> Matrix.set(1, 1, y)
    |> Matrix.set(2, 2, z)
  end

  @doc """
  A scaling matrix takes the form:
    [[ 1.0, x_y, x_z, 0.0 ],
     [ y_x, 1.0, y_z, 0.0 ],
     [ z_x, z_y, 1.0, 0.0 ],
     [ 0.0, 0.0, 0.0, 1.0 ]]
  """
  def shearingMatrix({x_y, x_z, y_x, y_z, z_x, z_y}) do
    [[1.0, x_y, x_z, 0.0],
     [y_x, 1.0, y_z, 0.0],
     [z_x, z_y, 1.0, 0.0],
     [0.0, 0.0, 0.0, 1.0]]
     |> Matrex.new
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
