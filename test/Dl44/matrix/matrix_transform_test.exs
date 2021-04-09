defmodule Dl44.Matrix.TransformTest do
  use ExUnit.Case
  use TestHelper

  alias Dl44.Matrix
  alias Dl44.Matrix.Transform
  alias Dl44.Point
  alias Dl44.Vector

  describe "Chaining Transformations" do
    test "Individiual transformations are applied in sequence" do
      p = Point.new(1, 0, 1)
      p
      |> Transform.rotate(:math.pi/2, :x)
      |> has(&Matrix.loose_equal?(&1, Point.new(1, -1, 0) |> Point.to_mat))
      |> Transform.scale({5, 5, 5})
      |> has(&Matrix.loose_equal?(&1, Point.new(5, -5, 0) |> Point.to_mat))
      |> Transform.translate({10, 5, 7})
      |> has(&Matrix.loose_equal?(&1, Point.new(15, 0, 7) |> Point.to_mat))
    end

    test "Chained transformations are applied in reverse" do
      p = Point.new(1, 0, 1) |> Point.to_mat
      a = Transform.rotation_x(:math.pi/2)
      b = Transform.scalingMatrix({5, 5, 5})
      c = Transform.translationMatrix({10, 5, 7})
      t = c
          |> Matrix.multiply(b)
          |> Matrix.multiply(a)
      assert Matrix.multiply(t, p) == Point.new(15, 0, 7) |> Point.to_mat
    end
  end

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

      assert Transform.scale(p, transform) == Point.new(-8, 18, 32) |> Point.to_mat
    end

    test "A scaling matrix applied to a vector" do
      transform = {2, 3, 4}
      v = Vector.new(-4, 6, 8)

      assert Transform.scale(v, transform) == Vector.new(-8, 18, 32) |> Vector.to_mat
    end

    test "Multiplying by the inverse of a scaling matrix" do
      transform = {2, 3, 4}
                  |> Transform.scalingMatrix
                  |> Matrix.inverse
      v = Vector.new(-4, 6, 8)

      assert Transform.scale(v, transform) == Vector.new(-2, 2, 2) |> Vector.to_mat
    end

    test "Reflection is scaling by a negative value" do
      transform = {-1, 1, 1}
      p = Point.new(2, 3, 4)

      assert Transform.scale(p, transform) == Point.new(-2, 3, 4) |> Point.to_mat
    end
  end

  describe "Shearing" do
    test "A shearing transformation moves x in proportion to y" do
      transform = {1, 0, 0, 0, 0, 0}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(5, 3, 4) |> Point.to_mat
    end

    test "A shearing transformation moves x in proportion to z" do
      transform = {0, 1, 0, 0, 0, 0}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(6, 3, 4) |> Point.to_mat
    end

    test "A shearing transformation moves y in proportion to x" do
      transform = {0, 0, 1, 0, 0, 0}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(2, 5, 4) |> Point.to_mat
    end

    test "A shearing transformation moves y in proportion to z" do
      transform = {0, 0, 0, 1, 0, 0}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(2, 7, 4) |> Point.to_mat
    end

    test "A shearing transformation moves z in proportion to x" do
      transform = {0, 0, 0, 0, 1, 0}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(2, 3, 6) |> Point.to_mat
    end

    test "A shearing transformation moves z in proportion to y" do
      transform = {0, 0, 0, 0, 0, 1}
      p = Point.new(2, 3, 4)

      assert Transform.shear(p, transform) == Point.new(2, 3, 7) |> Point.to_mat
    end
  end

  describe "Translation" do
    test "Multiplying by a translation matrix" do
      transform = {5, -3, 2}
      p = Point.new(-3, 4, 5)

      assert Transform.translate(p, transform) == Point.new(2, 1, 7) |> Point.to_mat
    end

    test "Multiplying by the inverse of a translation matrix" do
      transform = {5, -3, 2}
                  |> Transform.translationMatrix
                  |> Matrix.inverse
      p = Point.new(-3, 4, 5)

      assert Transform.translate(p, transform) == Point.new(-8, 7, 3) |> Point.to_mat
    end

    test "Translation does not affect vectors" do
      transform = {5, -3, 2}
      v = Vector.new(-3, 4, 5)

      assert Transform.translate(v, transform) == Vector.to_mat(v)
    end
  end
end
