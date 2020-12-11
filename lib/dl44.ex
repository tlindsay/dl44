defmodule Dl44 do
  alias Dl44.Point
  alias Dl44.Vector
  alias Dl44.Math

  def tick(_, %{position: %Point{x: _, y: y, z: _}, velocity: %Vector{}}) when y <= 0, do: IO.puts("DONE")
  def tick(%{gravity: %Vector{}, wind: %Vector{}} = env, %{position: %Point{}, velocity: %Vector{}} = proj) do
    position = Math.add(proj[:position], proj[:velocity])
    velocity = proj[:velocity]
               |> Math.add(env[:gravity])
               |> Math.add(env[:wind])

    IO.puts("X: #{position.x}, Y: #{position.y}, Z: #{position.z}")
    tick(env, %{position: position, velocity: velocity})
  end
end
