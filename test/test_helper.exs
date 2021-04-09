ExUnit.start()

# Pipe-able assertions
# Stolen from: https://dev.to/wulymammoth/using-pipes-in-your-test-assertions-43dk
defmodule TestHelper do
  defmacro __using__(_opts) do
    quote do
      import ExUnit.Assertions, only: [assert: 1]

      def is(result, expectation) do
        assert result == expectation
        result
      end

      def has(result, assertion) when is_function(assertion) do
        assert assertion.(result) == true
        result
      end
    end
  end
end
