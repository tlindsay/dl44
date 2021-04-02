defmodule Dl44.Matrix.Transform do
  alias Dl44.Matrix
  alias Dl44.Point
  alias Dl44.Vector

  def transform(:translate, _, v = %Vector{}), do: v
  def transform(type, t, p = %Point{}), do: transform(type, t, Point.to_mat(p))
  def transform(type, t, v = %Vector{}), do: transform(type, t, Vector.to_mat(v))
  def transform(:scale, t = {_x, _y, _z}, mat = %Matrex{}) do
    t
    |> scalingMatrix
    |> Matrix.multiply(mat)
  end
  def transform(:scale_inverse, t = {_x, _y, _z}, mat = %Matrex{}) do
    t
    |> scalingMatrix
    |> Matrix.inverse
    |> Matrix.multiply(mat)
  end
  def transform(:translate, t = {_x, _y, _z}, mat = %Matrex{}) do
    t
    |> translationMatrix
    |> Matrix.multiply(mat)
  end
  def transform(:translate_inverse, t = {_x, _y, _z}, mat = %Matrex{}) do
    t
    |> translationMatrix
    |> Matrix.inverse
    |> Matrix.multiply(mat)
  end
  def transform(unknown_translation, _, _) do
    raise {:error, "Unknown translation: #{unknown_translation}"}
  end

  def rotate(p = %Point{}, angle, axis), do: Point.to_mat(p) |> rotate(angle, axis)
  def rotate(v = %Vector{}, angle, axis), do: Vector.to_mat(v) |> rotate(angle, axis)
  def rotate(mat = %Matrex{}, angle, :x), do: rotation_x(angle) |> Matrix.multiply(mat)
  def rotate(mat = %Matrex{}, angle, :y), do: rotation_y(angle) |> Matrix.multiply(mat)
  def rotate(mat = %Matrex{}, angle, :z), do: rotation_z(angle) |> Matrix.multiply(mat)

  @doc """
  A rotation X matrix takes the form:
    [[ 0.0,    0.0,     0.0, 0.0 ],
     [ 0.0, cos(r), -sin(r), 0.0 ],
     [ 0.0, sin(r),  cos(r), 0.0 ],
     [ 0.0,    0.0,     0.0, 1.0 ]]
  """
  def rotation_x(r) do
    [[ 0.0,    0.0,     0.0, 0.0 ],
     [ 0.0, :math.cos(r), -:math.sin(r), 0.0 ],
     [ 0.0, :math.sin(r),  :math.cos(r), 0.0 ],
     [ 0.0,    0.0,     0.0, 1.0 ]]
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
