defmodule Dl44.Vector do
  alias Dl44.Vector
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 0.0

  @type vector :: %__MODULE__{
          x: float,
          y: float,
          z: float
        }

  def new(%{x: x, y: y, z: z}), do: %Vector{x: x/1, y: y/1, z: z/1}
  def new([x, y, z]), do: %Vector{x: x/1, y: y/1, z: z/1}
  def new(n \\ 0.0), do: %Vector{x: n/1, y: n/1, z: n/1}
  def new(x, y, z), do: %Vector{x: x/1, y: y/1, z: z/1}

  def magnitude(%Vector{x: x, y: y, z: z}) do
    [x, y, z]
    |> Enum.map(fn n -> n * n end)
    |> Enum.reduce(0, &+/2)
    |> :math.sqrt
  end
end
