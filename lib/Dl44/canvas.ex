defmodule Dl44.Canvas do
  alias Dl44.Canvas
  alias Dl44.Color

  defstruct width: 0, height: 0, pixels: Matrix

  def new(width \\ 0, height \\ 0, color \\ Color.new) do
    pixels = Matrix.new(height, width, color)
    %Canvas{width: width, height: height, pixels: pixels}
  end

  def pixel_at(%Canvas{pixels: p}, x, y) when is_integer(x) and is_integer(y) do
    Matrix.elem(p, x, y)
  end

  def write_pixel(%Canvas{width: w, height: h, pixels: p}, x, y, %Color{} = color) when is_integer(x) and is_integer(y) do
    %Canvas{
      width: w,
      height: h,
      pixels: Matrix.set(p, y, x, color)
    }
  end

  def to_ppm(%Canvas{width: w, height: h, pixels: p}) do
    """
    P3
    #{w} #{h}
    255
    #{pixels_to_ppm(p)}
    """
  end

  defp pixels_to_ppm(pixels) do
    pixels
    |> Enum.map(&pixel_row_to_ppm/1)
    |> Enum.join("\n")
  end

  defp pixel_row_to_ppm(row) do
    row
    |> Enum.map(&pixel_to_ppm/1)
    |> Enum.join(" ")
  end

  defp pixel_to_ppm(%Color{r: r, g: g, b: b}) do
    "#{color_to_ppm(r)} #{color_to_ppm(g)} #{color_to_ppm(b)}"
  end

  defp color_to_ppm(c) when c <= 0.0, do: 0
  defp color_to_ppm(c) when c >= 1.0, do: 255
  defp color_to_ppm(c) do
    floor(c * 256.0)
  end
end
