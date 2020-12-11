defmodule Dl44.CanvasTest do
  use ExUnit.Case
  doctest Dl44.Canvas

  alias Dl44.Canvas
  alias Dl44.Color

  describe "Canvas.new" do
    test "initializes blank canvas" do
      color = %Color{r: 0.0, g: 0.0, b: 0.0}
      pixels = [
        [color, color, color],
        [color, color, color],
        [color, color, color]
      ]
      canvas = %Canvas{width: 3, height: 3, pixels: pixels}
      assert Canvas.new(3, 3) == canvas
    end

    test "initializes colored canvas" do
      color = %Color{r: 1.0, g: 0.0, b: 0.0}
      pixels = [
        [color, color, color],
        [color, color, color],
        [color, color, color]
      ]
      canvas = %Canvas{width: 3, height: 3, pixels: pixels}
      assert Canvas.new(3, 3, color) == canvas
    end
  end

  describe "Canvas.write_pixel" do
    test "updates the specified pixel" do
      red = %Color{r: 1.0, g: 0.0, b: 0.0}
      blue = %Color{r: 0.0, g: 0.0, b: 1.0}
      pixels = [
        [red, red, red],
        [red, red, red],
        [red, red, red]
      ]
      canvas = %Canvas{width: 3, height: 3, pixels: pixels}
      assert Canvas.pixel_at(canvas, 1, 1) == red

      canvas = Canvas.write_pixel(canvas, 1, 1, blue)
      assert Canvas.pixel_at(canvas, 1, 1) == blue
    end
  end

  describe "Canvas.pixel_at" do
    test "returns the value of the specified pixel" do
      red = %Color{r: 1.0, g: 0.0, b: 0.0}
      blue = %Color{r: 0.0, g: 0.0, b: 1.0}
      pixels = [
        [red, red, red],
        [red, blue, red],
        [red, red, red]
      ]
      canvas = %Canvas{width: 3, height: 3, pixels: pixels}

      assert Canvas.pixel_at(canvas, 0, 0) == red
      assert Canvas.pixel_at(canvas, 1, 1) == blue
    end
  end
end
