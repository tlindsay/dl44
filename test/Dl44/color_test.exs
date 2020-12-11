defmodule Dl44.ColorTest do
  use ExUnit.Case
  doctest Dl44.Color

  alias Dl44.Color

  describe "Color.new" do
    test "accepts a map" do
      assert Color.new(%{r: 1, g: 2, b: 3}) == %Color{r: 1.0, g: 2.0, b: 3.0}
    end

    test "accepts a single value" do
      assert Color.new(1) == %Color{r: 1.0, g: 1.0, b: 1.0}
    end

    test "accepts a list" do
      assert Color.new([1, 2, 3]) == %Color{r: 1.0, g: 2.0, b: 3.0}
    end

    test "accepts no arguments" do
      assert Color.new() == %Color{r: 0.0, g: 0.0, b: 0.0}
    end

    test "accepts a list of arguments" do
      assert Color.new(1, 2, 3) == %Color{r: 1.0, g: 2.0, b: 3.0}
    end
  end

  describe "Color arithmetc" do
    test "Color.add" do
      c1 = Color.new(1.0, 0.0, 0.0)
      c2 = Color.new(0.0, 1.0, 0.0)

      assert Color.add(c1, c2) == %Color{r: 1.0, g: 1.0, b: 0.0}
    end

    test "Color.sub" do
      c1 = Color.new(1.0)
      c2 = Color.new(0.2)

      assert Color.sub(c1, c2) == %Color{r: 0.8, g: 0.8, b: 0.8}
    end

    test "Color.product" do
      c1 = Color.new(1, 0.2, 0.4)
      c2 = Color.new(0.9, 1, 0.1)

      assert Color.product(c1, c2) == %Color{r: 0.9, g: 0.2, b: 0.04}
    end

    test "Color.scale" do
      c = Color.new(0.5)

      assert Color.scale(c, 2.0) == %Color{r: 1.0, g: 1.0, b: 1.0}
    end
  end
end
