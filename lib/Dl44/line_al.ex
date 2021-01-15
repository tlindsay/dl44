defmodule Dl44.LineAl do
  alias Dl44.Vector # w: 0.0
  alias Dl44.Point # w: 1.0

  @doc """
  iex> v = Dl44.Vector.new(3)
  iex> p = Dl44.Point.new(4)
  iex> Dl44.LineAl.add(p, v)
  %Dl44.Point{x: 7.0, y: 7.0, z: 7.0}
  """
  def add(%Vector{} = a, %Vector{} = b), do: a |> do_add(b) |> Vector.new
  def add(%Point{} = a, %Vector{} = b), do: a |> do_add(b) |> Point.new

  defp do_add(%{x: x1, y: y1, z: z1}, %{x: x2, y: y2, z: z2}) do
    [
      x1 + x2,
      y1 + y2,
      z1 + z2
    ]
  end

  @doc """
  iex> v = Dl44.Vector.new(3)
  iex> p = Dl44.Point.new(4)
  iex> Dl44.LineAl.sub(p, v)
  %Dl44.Point{x: 1.0, y: 1.0, z: 1.0}
  """
  def sub(%Vector{} = a, %Vector{} = b), do: a |> do_sub(b) |> Vector.new
  def sub(%Point{} = a, %Vector{} = b), do: a |> do_sub(b) |> Point.new

  defp do_sub(%{x: x1, y: y1, z: z1}, %{x: x2, y: y2, z: z2}) do
    [
      x1 - x2,
      y1 - y2,
      z1 - z2
    ]
  end

  @doc """
  iex> v = Dl44.Vector.new(3)
  iex> Dl44.LineAl.scale(v, 2)
  %Dl44.Vector{x: 6.0, y: 6.0, z: 6.0}
  """
  def scale(%Vector{x: x, y: y, z: z}, n) when is_number(n) do
    Vector.new(
      x * n,
      y * n,
      z * n
    )
  end

  @doc """
  iex> v = Dl44.Vector.new(3)
  iex> Dl44.LineAl.dot(v, v)
  27.0
  """
  def dot(%Vector{x: x1, y: y1, z: z1}, %Vector{x: x2, y: y2, z: z2}) do
    (x1 * x2) +
    (y1 * y2) +
    (z1 * z2)
  end

  @doc """
  iex> v = Dl44.Vector.new(3)
  iex> Dl44.LineAl.cross(v, v)
  %Dl44.Vector{x: 0.0, y: 0.0, z: 0.0}
  """
  def cross(%Vector{x: x1, y: y1, z: z1}, %Vector{x: x2, y: y2, z: z2}) do
    Vector.new(
      (y1 * z2) - (z1 * y2),
      (z1 * x2) - (x1 * z2),
      (x1 * y2) - (y1 * x2)
    )
  end
end
