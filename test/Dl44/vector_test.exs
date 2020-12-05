defmodule Dl44.VectorTest do
  use ExUnit.Case
  doctest Dl44.Vector

  alias Dl44.Vector

  describe "Vector.new" do
    test "accepts a map" do
      assert Vector.new(%{x: 1, y: 2, z: 3}) == %Vector{x: 1.0, y: 2.0, z: 3.0}
    end

    test "accepts a single value" do
      assert Vector.new(1) == %Vector{x: 1.0, y: 1.0, z: 1.0}
    end

    test "accepts a list" do
      assert Vector.new([1, 2, 3]) == %Vector{x: 1.0, y: 2.0, z: 3.0}
    end

    test "accepts no arguments" do
      assert Vector.new() == %Vector{x: 0.0, y: 0.0, z: 0.0}
    end

    test "accepts a list of arguments" do
      assert Vector.new(1, 2, 3) == %Vector{x: 1.0, y: 2.0, z: 3.0}
    end
  end

  describe "Vector.magnitude" do
    test "calculates magnitude" do
      # Magnitude is sqrt(x^2 + y^2 + z^2)
      v = Vector.new(1, 2, 3)
      result = Vector.magnitude(v)
      assert result == :math.sqrt(14)
    end
  end
end

