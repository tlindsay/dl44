defmodule Dl44 do
  defdelegate add(a, b), to: Dl44.Math
  defdelegate sub(a, b), to: Dl44.Math
end
