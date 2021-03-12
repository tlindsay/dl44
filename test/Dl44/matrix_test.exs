defmodule Dl44.MatrixTest do
  use ExUnit.Case
  doctest Dl44.Matrix

  alias Dl44.Matrix

  describe "Matrix.loose_equal?" do
    test "it returns true for two strictlye equal matrices" do
      m1 = Matrix.new("1,2,3; 4,5,6; 7,8,9")
      m2 = Matrix.new("1,2,3; 4,5,6; 7,8,9")

      assert Matrix.loose_equal?(m1, m2) == true
    end

    test "it returns true for two loosely equal matrices" do
      m1 = Matrix.new("1,2,3; 4,5,6; 7,8,9")
      m2 = Matrix.new("1.00000000001,2,2.999999999999; 4,5,6; 7,8,9")

      assert Matrix.loose_equal?(m1, m2) == true
    end

    test "it returns false for two unequal matrices" do
      m1 = Matrix.new("1,1,1; 2,2,2; 3,3,3")
      m2 = Matrix.new("4,4,4; 5,5,5; 6,6,6")

      assert Matrix.loose_equal?(m1, m2) == false
    end

    test "it returns false for two almost equal matrices" do
      m1 = Matrix.new("1,1,1; 2,2,2; 3,3,3")
      m2 = Matrix.new("1.1,1,1; 2,2,2; 3,3,3")

      assert Matrix.loose_equal?(m1, m2) == false
    end
  end

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
    test "can calculate the inverse of a matrix" do
      m = Matrix.new("-5,2,6,-8; 1,-5,1,8; 7,7,-6,-7; 1,-3,7,4")
      inv = Matrix.new([
        [ 0.21805,  0.45113,  0.24060, -0.04511],
        [-0.80827, -1.45677, -0.44361,  0.52068],
        [-0.07895, -0.22368, -0.05263,  0.19737],
        [-0.52256, -0.81391, -0.30075,  0.30639]
      ])

      assert Matrix.determinant(m) == 532
      assert Matrix.cofactor(m, 2, 3) == -160
      assert m
             |> Matrix.inverse
             |> Matrix.loose_equal?(inv)
    end

    test "can calculate the inverse of a second matrix" do
      m = Matrix.new("8,-5,9,2; 7,5,6,1; -6,0,9,6; -3,0,-9,-4")
      inv = Matrix.new([
        [ -0.15385, -0.15385, -0.28205, -0.53846 ],
        [ -0.07692,  0.12308,  0.02564,  0.03077 ],
        [  0.35897,  0.35897,  0.43590,  0.92308 ],
        [ -0.69231, -0.69231, -0.76923, -1.92308 ]
      ])

      assert m
             |> Matrix.inverse
             |> Matrix.loose_equal?(inv)
    end

    test "can calculate the inverse of a third matrix" do
      m = Matrix.new("9,3,0,9; -5,-2,-6,-3; -4,9,6,4; -7,6,6,2")
      inv = Matrix.new([
        [ -0.04074, -0.07778,  0.14444, -0.22222 ],
        [ -0.07778,  0.03333,  0.36667, -0.33333 ],
        [ -0.02901, -0.14630, -0.10926,  0.12963 ],
        [  0.17778,  0.06667, -0.26667,  0.33333 ]
      ])

      assert m
             |> Matrix.inverse
             |> Matrix.loose_equal?(inv)
    end

    test "multiplying a matrix by its inverse" do
      m1 = Matrix.new("3,-9,7,3; 3,-8,2,-9; -4,4,4,1; -6,5,-1,1")
      m2 = Matrix.new("8,2,2,2; 3,-1,7,0; 7,0,5,4; 6,-2,0,5")
      prod = Matrix.multiply(m1, m2)
      inv = Matrix.inverse(m2)

      assert Matrix.multiply(prod, inv) |> Matrix.loose_equal?(m1)
    end
  end

  describe "Matrix.determinant" do
    test "can calculate determinant of 2x2 matrix" do
      m = Matrix.new("1,5;-3,2")
      assert Matrix.determinant(m) == 17
    end

    test "it can calculate determinant of a 3x3 matrix" do
      m = Matrix.new("1,2,6; -5,8,-4; 2,6,4")
      assert Matrix.cofactor(m, 0, 0) == 56
      assert Matrix.cofactor(m, 0, 1) == 12
      assert Matrix.cofactor(m, 0, 2) == -46
      assert Matrix.determinant(m) == -196
    end
  end

  describe "Matrix.invertible?" do
    test "it can detect invertibility" do
      m = Matrix.new("6,4,4,4; 5,5,7,6; 4,-9,3,-7; 9,1,7,6")
      assert Matrix.invertible?(m) == true

      m2 = Matrix.new("-4,2,-2,-3; 9,6,2,6; 0,-5,1,-5; 0,0,0,0")
      assert Matrix.determinant(m2) == 0
      assert Matrix.invertible?(m2) == false
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
