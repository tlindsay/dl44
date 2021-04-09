defmodule Dl44.Clock do
  alias Dl44.Canvas
  alias Dl44.Color
  alias Dl44.Matrix.Transform
  alias Dl44.Point

  @w 400
  @h 400
  @center_x @w/2
  @center_y @h/2
  @radius @w/4
  @rotation -:math.pi/6
  @twelve Point.new(0, 0, 1)

  def run do
    canvas = Canvas.new(@w, @h)

    (1..12)
    |> Enum.reduce(canvas, fn n, c ->
      @twelve
      |> Transform.rotate(n*@rotation, :y)
      |> Point.from_mat()
      |> write(c)
    end)
    |> Canvas.to_ppm
  end

  def write(%Point{x: x, z: z}, canvas = %Canvas{}) do
    color = Color.new()
    x = floor(@center_x - x * @radius)
    z = floor(@center_y - z * @radius)

    canvas
    |> Canvas.write_pixel(x, z, color)
  end
end
