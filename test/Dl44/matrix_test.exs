defmodule Dl44.MatrixTest do
  use ExUnit.Case
  doctest Dl44.Matrix

  alias Dl44.Matrix

  # Methods
  # [ ] create
  # [ ] compare
  # [-] multiply matrices
  # [ ] multiply matrix by tuple
  # [-] create identity matrix
  # [-] transpose matrix
  # [ ] invert matrix
  # [ ] calculate determinant
  # [-] calculate submatrix(matrix, row, column)
  # [ ] calculate minor(matrix, row, column)
  # [ ] calculate cofactor

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
    test "can calculate determinant of 2x2 matrix" do
      m = Matrix.new("1,5;-3,2")
      assert Matrix.determinant(m) == 17
    end
  end

  describe "Matrix.minor" do
    test "can calculate the minor of a matrix" do
      m = Matrix.new("3,5,0; 2,-1,-7; 6,-1,5")
      assert Matrix.minor(m, 1, 0) == 25
    end
  end

  describe "Matrix.submatrix" do
    test "it drops the specified row/col" do
      m = Matrix.new("3,5,0; 2,-1,-7; 6,-1,5")
      assert Matrix.submatrix(m, 1, 1) == Matrix.new("3,0; 6,5")
    end
  end

  describe "Matrix.cofactor" do
    test "it calculates cofactors" do
      m = Matrix.new("3,5,0; 2,-1,-7; 6,-1,5")

      assert Matrix.minor(m, 0, 0) == -12
      assert Matrix.cofactor(m, 0, 0) == -12
      assert Matrix.minor(m, 1, 0) == 25
      assert Matrix.cofactor(m, 1, 0) == -25
    end
  end
end
