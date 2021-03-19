defmodule Dl44.Point do
  alias Dl44.Point
  alias Dl44.Matrix
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 1.0

  @type point :: %__MODULE__{
          x: float,
          y: float,
          z: float
        }

  def new(n \\ 0.0)
  def new(%{x: x, y: y, z: z}), do: %Point{x: x/1, y: y/1, z: z/1}
  def new([x, y, z]), do: %Point{x: x/1, y: y/1, z: z/1}
  def new(n), do: %Point{x: n/1, y: n/1, z: n/1}
  def new(x, y, z), do: %Point{x: x/1, y: y/1, z: z/1}

  def to_mat(%Point{x: x, y: y, z: z, w: w}), do: Matrix.new([[x, y, z, w]]) |> Matrix.transpose
end
