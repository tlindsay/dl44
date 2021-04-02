defmodule Dl44.Matrix.TransformTest do
  use ExUnit.Case

  alias Dl44.Matrix
  alias Dl44.Matrix.Transform
  alias Dl44.Point
  alias Dl44.Vector

  describe "Rotation" do
    test "Rotating a point around the x-axis" do
      p = Point.new(0, 1, 0)

      rotated_half = Point.new(0, :math.sqrt(2)/2.0, :math.sqrt(2)/2.0) |> Point.to_mat
      rotated_full = Point.new(0, 0, 1) |> Point.to_mat

      assert Transform.rotate(p, :math.pi/4, :x) |> Matrix.loose_equal?(rotated_half)
      assert Transform.rotate(p, :math.pi/2, :x) |> Matrix.loose_equal?(rotated_full)
    end
  end

  describe "Scaling" do
    test "A scaling matrix applied to a point" do
      transform = {2, 3, 4}
      p = Point.new(-4, 6, 8)

      assert Transform.transform(:scale, transform, p) == Point.new(-8, 18, 32) |> Point.to_mat
    end

    test "A scaling matrix applied to a vector" do
      transform = {2, 3, 4}
      v = Vector.new(-4, 6, 8)

      assert Transform.transform(:scale, transform, v) == Vector.new(-8, 18, 32) |> Vector.to_mat
    end

    test "Multiplying by the inverse of a scaling matrix" do
      transform = {2, 3, 4}
      v = Vector.new(-4, 6, 8)

      assert Transform.transform(:scale_inverse, transform, v) == Vector.new(-2, 2, 2) |> Vector.to_mat
    end

    test "Reflection is scaling by a negative value" do
      transform = {-1, 1, 1}
      p = Point.new(2, 3, 4)

      assert Transform.transform(:scale, transform, p) == Point.new(-2, 3, 4) |> Point.to_mat
    end
  end

  describe "Translation" do
    test "Multiplying by a translation matrix" do
      transform = {5, -3, 2}
      p = Point.new(-3, 4, 5)

      assert Transform.transform(:translate, transform, p) == Point.new(2, 1, 7) |> Point.to_mat
    end

    test "Multiplying by the inverse of a translation matrix" do
      transform = {5, -3, 2}
      p = Point.new(-3, 4, 5)

      assert Transform.transform(:translate_inverse, transform, p) == Point.new(-8, 7, 3) |> Point.to_mat
    end

    test "Translation does not affect vectors" do
      transform = {5, -3, 2}
      v = Vector.new(-3, 4, 5)

      assert Transform.transform(:translate, transform, v) == v
    end
  end
end
