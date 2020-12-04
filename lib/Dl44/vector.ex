defmodule Dl44.Vector do
  @enforce_keys [:x, :y, :z]
  defstruct [:x, :y, :z, w: 0.0]

  @type vector :: %__MODULE__{
          x: float,
          y: float,
          z: float
        }
end
