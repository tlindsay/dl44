defmodule Dl44.MathTest do
  use ExUnit.Case
  doctest Dl44.Math

  alias Dl44.Math
  alias Dl44.Point
  alias Dl44.Vector

  describe "Math.add" do
    test "adds points together" do
      p = Point.new(%{x: 4.0, y: 5.0, z: 6.0})
      assert Math.add(p, p) == Point.new(%{x: 8.0, y: 10.0, z: 12.0})
    end

    test "adds vectors together" do
      v = Vector.new(%{x: 1.0, y: 2.0, z: 3.0})
      assert Math.add(v, v) == Vector.new(%{x: 2.0, y: 4.0, z: 6.0})
    end

    test "adds points and vectors" do
      v = Vector.new(%{x: 1.0, y: 2.0, z: 3.0})
      p = Point.new(%{x: 4.0, y: 5.0, z: 6.0})
      result = Point.new(%{x: 5.0, y: 7.0, z: 9.0})

      assert Math.add(p, v) == result
      assert Math.add(v, p) == result
    end
  end

  describe "Math.sub" do
    test "subtracts two points" do
      p1 = Point.new(%{x: 3, y: 2, z: 1})
      p2 = Point.new(%{x: 5, y: 6, z: 7})

      assert Math.sub(p1, p2) == Vector.new(%{x: -2.0, y: -4.0, z: -6.0})
    end

    test "subtracts a vector from a point" do
      p = Point.new(%{x: 3, y: 2, z: 1})
      v = Vector.new(%{x: 5, y: 6, z: 7})

      assert Math.sub(p, v) == Point.new(%{x: -2.0, y: -4.0, z: -6.0})
    end

    test "subtracts two vectors" do
      v1 = Vector.new(%{x: 3, y: 2, z: 1})
      v2 = Vector.new(%{x: 5, y: 6, z: 7})

      assert Math.sub(v1, v2) == Vector.new(%{x: -2.0, y: -4.0, z: -6.0})
    end
  end
end
