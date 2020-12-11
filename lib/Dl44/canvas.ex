defmodule Dl44.Canvas do
  alias Dl44.Canvas
  alias Dl44.Color

  defstruct width: 0, height: 0, pixels: Matrix

  def new(width \\ 0, height \\ 0, color \\ Color.new) do
    pixels = Matrix.new(width, height, color)
    %Canvas{width: width, height: height, pixels: pixels}
  end

  def pixel_at(%Canvas{pixels: p}, x, y) when is_integer(x) and is_integer(y) do
    Matrix.elem(p, x, y)
  end

  def write_pixel(%Canvas{width: w, height: h, pixels: p} = canvas, x, y, %Color{} = color) when is_integer(x) and is_integer(y) do
    %Canvas{
      width: w,
      height: h,
      pixels: Matrix.set(p, x, y, color)
    }
  end
end
