defmodule Dl44.LineAlTest do
  use ExUnit.Case
  doctest Dl44.LineAl

  alias Dl44.LineAl
  alias Dl44.Point
  alias Dl44.Vector

  describe "LineAl.add/2" do
    test "adds vectors together" do
      v = Vector.new(%{x: 1.0, y: 2.0, z: 3.0})
      assert LineAl.add(v, v) == Vector.new(%{x: 2.0, y: 4.0, z: 6.0})
    end

    test "adds points and vectors" do
      v = Vector.new(%{x: 1.0, y: 2.0, z: 3.0})
      p = Point.new(%{x: 4.0, y: 5.0, z: 6.0})
      result = Point.new(%{x: 5.0, y: 7.0, z: 9.0})

      assert LineAl.add(p, v) == result
    end
  end

  describe "LineAl.sub/2" do
    test "subtracts a vector from a point" do
      p = Point.new(%{x: 3, y: 2, z: 1})
      v = Vector.new(%{x: 5, y: 6, z: 7})

      assert LineAl.sub(p, v) == Point.new(%{x: -2.0, y: -4.0, z: -6.0})
    end

    test "subtracts two vectors" do
      v1 = Vector.new(%{x: 3, y: 2, z: 1})
      v2 = Vector.new(%{x: 5, y: 6, z: 7})

      assert LineAl.sub(v1, v2) == Vector.new(%{x: -2.0, y: -4.0, z: -6.0})
    end
  end

  describe "LineAl.scale/2" do
    test "scales a vector up" do
      v = Vector.new(1, 2, 3)
      assert LineAl.scale(v, 2) == Vector.new(2, 4, 6)
    end

    test "scales a vector down" do
      v = Vector.new(2, 4, 6)
      assert LineAl.scale(v, 0.5) == Vector.new(1, 2, 3)
    end
  end

  describe "LineAl.dot/2" do
    test "calculates the dot product of two vectors" do
      v1 = Vector.new(1, 2, 3)
      v2 = Vector.new(2, 3, 4)

      assert LineAl.dot(v1, v2) == 20.0
    end
  end

  describe "LineAl.cross/2" do
    test "calculates the cross product of two vectors" do
      v1 = Vector.new(1, 2, 3)
      v2 = Vector.new(2, 3, 4)

      assert LineAl.cross(v1, v2) == Vector.new(-1, 2, -1)
      assert LineAl.cross(v2, v1) == Vector.new(1, -2, 1)
    end
  end
end
