defmodule Dl44.Matrix.TransformTest do
  use ExUnit.Case

  alias Dl44.Matrix
  alias Dl44.Matrix.Transform
  alias Dl44.Point
  alias Dl44.Vector

  describe "Translation" do
    test "Multiplying by a translation matrix" do
      transform = {5, -3, 2}
      p = Point.new(-3, 4, 5)

      assert Transform.translate(transform, p) == Point.new(2, 1, 7) |> Point.to_mat
    end

    test "Multiplying by the inverse of a translation matrix" do
      transform = Transform.translationMatrix({5, -3, 2})
      inv = Matrix.inverse(transform)
      p = Point.new(-3, 4, 5)

      assert Transform.translate(inv, p) == Point.new(-8, 7, 3) |> Point.to_mat
    end

    test "Translation does not affect vectors" do
      transform = {5, -3, 2}
      v = Vector.new(-3, 4, 5)

      assert Transform.translate(transform, v) == v
    end
  end
end
