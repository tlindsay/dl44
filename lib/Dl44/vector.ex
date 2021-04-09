defmodule Dl44.Vector do
  alias Dl44.Vector
  alias Dl44.Matrix
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 0.0

  @type vector :: %__MODULE__{
          x: float,
          y: float,
          z: float
        }

  def new(n \\ 0.0)
  def new(%{x: x, y: y, z: z}), do: %Vector{x: x/1, y: y/1, z: z/1}
  def new([x, y, z]), do: %Vector{x: x/1, y: y/1, z: z/1}
  def new([x, y, z, 0.0]), do: %Vector{x: x/1, y: y/1, z: z/1}
  def new(n), do: %Vector{x: n/1, y: n/1, z: n/1}
  def new(x, y, z), do: %Vector{x: x/1, y: y/1, z: z/1}

  def to_mat(%Vector{x: x, y: y, z: z, w: w}), do: Matrix.new([[x, y, z, w]]) |> Matrix.transpose
  def from_mat(m = %Matrex{}), do: Matrex.to_list(m) |> Vector.new

  def magnitude(%Vector{x: x, y: y, z: z}) do
    [x, y, z]
    |> Enum.map(fn n -> n * n end)
    |> Enum.reduce(0, &+/2)
    |> :math.sqrt
  end

  def normalize(%Vector{x: x, y: y, z: z}) do
    mag = magnitude(%Vector{x: x, y: y, z: z})

    new(
      x/mag,
      y/mag,
      z/mag
    )
  end
end
