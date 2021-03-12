defmodule Dl44.MatrixTest do
  use ExUnit.Case
  doctest Dl44.Matrix

  alias Dl44.Matrix

  describe "Matrix.multiply" do
    test "can multiply by a tuple" do
      m = Matrix.new([[1, 2, 3, 4],
                      [2, 4, 4, 2],
                      [8, 6, 4, 1],
                      [0, 0, 0, 1]])
      t = {1, 2, 3, 1}
      assert Matrix.multiply(m, t) == {18, 24, 33, 1}
    end
  end

  describe "Matrix.inverse" do

  end

  describe "Matrix.determinant" do

  end

  describe "Matrix.minor" do

  end

  describe "Matrix.cofactor" do

  end
end
