defmodule Dl44.MathTest do
  use ExUnit.Case
  doctest Dl44.Math

  alias Dl44.Math
  alias Dl44.Point
  alias Dl44.Vector

  setup_all do
    v = %Vector{x: 1.0, y: 2.0, z: 3.0}
    p = %Point{x: 4.0, y: 5.0, z: 6.0}
    {:ok , v: v, p: p}
  end

  describe "Math.add" do
    test "adds points together", state do
      p = state[:p]
      assert Math.add(p, p) == %Point{x: 8.0, y: 10.0, z: 12.0}
    end

    test "adds vectors together", state do
      v = state[:v]
      assert Math.add(v, v) == %Vector{x: 2.0, y: 4.0, z: 6.0}
    end

    test "adds points and vectors", state do
      p = state[:p]
      v = state[:v]
      result = %Point{x: 5.0, y: 7.0, z: 9.0}

      assert Math.add(p, v) == result
      assert Math.add(v, p) == result
    end
  end

  describe "Math.sub" do
    test "subtracts two points" do
      p1 = %Point{x: 3, y: 2, z: 1}
      p2 = %Point{x: 5, y: 6, z: 7}

      assert Math.sub(p1, p2) == %Vector{x: -2.0, y: -4.0, z: -6.0}
    end

    test "subtracts a vector from a point" do
      p = %Point{x: 3, y: 2, z: 1}
      v = %Vector{x: 5, y: 6, z: 7}

      assert Math.sub(p, v) == %Point{x: -2.0, y: -4.0, z: -6.0}
    end

    test "subtracts two vectors" do
      v1 = %Vector{x: 3, y: 2, z: 1}
      v2 = %Vector{x: 5, y: 6, z: 7}

      assert Math.sub(v1, v2) == %Vector{x: -2.0, y: -4.0, z: -6.0}
    end
  end
end
