defmodule Dl44.PointTest do
  use ExUnit.Case
  doctest Dl44.Point

  alias Dl44.Point

  describe "Point.new" do
    test "accepts a map" do
      assert Point.new(%{x: 1, y: 2, z: 3}) == %Point{x: 1.0, y: 2.0, z: 3.0}
    end

    test "accepts a single value" do
      assert Point.new(1) == %Point{x: 1.0, y: 1.0, z: 1.0}
    end

    test "accepts a list" do
      assert Point.new([1, 2, 3]) == %Point{x: 1.0, y: 2.0, z: 3.0}
    end

    test "accepts no arguments" do
      assert Point.new() == %Point{x: 0.0, y: 0.0, z: 0.0}
    end

    test "accepts a list of arguments" do
      assert Point.new(1, 2, 3) == %Point{x: 1.0, y: 2.0, z: 3.0}
    end
  end
end

