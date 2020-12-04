defmodule Dl44.Point do
  @enforce_keys [:x, :y, :z]
  defstruct [:x, :y, :z, w: 1.0]

  @type point :: %__MODULE__{
          x: float,
          y: float,
          z: float
        }
end
