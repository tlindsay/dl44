defmodule Mix.Tasks.Clock do
  use Mix.Task
  alias Dl44.Clock

  def run(args) do
    options = [switches: [output: :string], aliases: [o: :output]]
    {opts, _, _} = OptionParser.parse(args, options)

    [output: outfile] = opts

    ppm = Clock.run

    File.write!(outfile, ppm)
  end
end
