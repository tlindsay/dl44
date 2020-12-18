defmodule Dl44.Simulation do
  alias Dl44.Canvas
  alias Dl44.Color
  alias Dl44.Point
  alias Dl44.Vector
  alias Dl44.Math

  def run() do
    canvas = Canvas.new(900, 550)
    velocity =
      Vector.new(1, 1.8, 0)
      |> Vector.normalize
      |> Math.scale(11.25)
    start = Point.new(0, 1, 0)
    gravity = Vector.new(0, -0.1, 0)
    wind = Vector.new(-0.01, 0, 0)
    env = %{gravity: gravity, wind: wind}
    proj = %{position: start, velocity: velocity}

    tick(env, proj, canvas)
    |> Canvas.to_ppm
  end

  defp tick(_, %{position: %Point{x: _, y: y, z: _}, velocity: %Vector{}}, %Canvas{} = canvas) when y <= 0, do: canvas
  defp tick(%{gravity: %Vector{}, wind: %Vector{}} = env, %{position: %Point{}, velocity: %Vector{}} = proj, %Canvas{} = canvas) do
    position = Math.add(proj[:position], proj[:velocity])
    velocity = proj[:velocity]
               |> Math.add(env[:gravity])
               |> Math.add(env[:wind])

    px =
      position.x
      |> floor
      |> max(0)
      |> min(canvas.width - 1)
    py =
      (canvas.height - position.y)
      |> floor
      |> max(0)
      |> min(canvas.height - 1)

    color = Color.new(0.99, 0.67, 0.64)
    canvas = Canvas.write_pixel(canvas, px, py, color)

    tick(env, %{position: position, velocity: velocity}, canvas)
  end
end
