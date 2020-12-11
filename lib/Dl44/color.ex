defmodule Dl44.Color do
  alias Dl44.Color
  defstruct r: 0.0, g: 0.0, b: 0.0

  defguard is_numeric(val) when is_integer(val) or is_float(val)

  @type color ::%__MODULE__{
          r: float,
          g: float,
          b: float
        }

  def new(n \\ 0.0) when is_numeric(n), do: %Color{r: n/1, g: n/1, b: n/1}
  def new(%{r: r, g: g, b: b}), do: %Color{r: r/1, g: g/1, b: b/1}
  def new([r, g, b]), do: %Color{r: r/1, g: g/1, b: b/1}
  def new(r, g, b), do: %Color{r: r/1, g: g/1, b: b/1}

  def add(%Color{r: r1, g: g1, b: b1}, %Color{r: r2, g: g2, b: b2}) do
    Color.new(
      [
        r1 + r2,
        g1 + g2,
        b1 + b2
      ] |> Enum.map(&(Float.round(&1, 15)))
    )
  end

  def sub(%Color{r: r1, g: g1, b: b1}, %Color{r: r2, g: g2, b: b2}) do
    Color.new(
      [
        r1 - r2,
        g1 - g2,
        b1 - b2
      ] |> Enum.map(&(Float.round(&1, 15)))
    )
  end

  def product(%Color{r: r1, g: g1, b: b1}, %Color{r: r2, g: g2, b: b2}) do
    Color.new(
      [
        r1 * r2,
        g1 * g2,
        b1 * b2
      ] |> Enum.map(&(Float.round(&1, 15)))
    )
  end

  def scale(%Color{r: r, g: g, b: b}, n) when is_numeric(n) do
    Color.new(
      [
        r * n,
        g * n,
        b * n
      ] |> Enum.map(&(Float.round(&1, 15)))
    )
  end
end
