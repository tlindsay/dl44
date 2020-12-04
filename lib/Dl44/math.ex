defmodule Dl44.Math do
  alias Dl44.Vector
  alias Dl44.Point

  defguard p_or_v(type) when type in [Vector, Point]
  defguard p_or_v(type1, type2) when p_or_v(type1) and p_or_v(type2)
  defguard is_numeric(val) when is_integer(val) or is_float(val)

  def add(%type1{x: x1, y: y1, z: z1}, %type2{x: x2, y: y2, z: z2}) when p_or_v(type1, type2) do
    new_type =
      case {type1, type2} do
        {Vector, Vector} -> Vector
        _ -> Point
      end

    struct!(
      new_type,
      x: x1 + x2,
      y: y1 + y2,
      z: z1 + z2
    )
  end

  def sub(%type1{x: x1, y: y1, z: z1}, %type2{x: x2, y: y2, z: z2}) when p_or_v(type1, type2) do
    new_type =
      case {type1, type2} do
        {Point, Vector} -> Point
        {Vector, Point} -> Point
        _ -> Vector
      end
    struct!(
      new_type,
      x: x1 - x2,
      y: y1 - y2,
      z: z1 - z2
    )
  end

  def scale(%tup{x: x, y: y, z: z}, scalar \\ 1.0) when p_or_v(tup) and is_numeric(scalar) do
    struct!(
      tup,
      x: x * scalar,
      y: y * scalar,
      z: z * scalar
    )
  end
end
