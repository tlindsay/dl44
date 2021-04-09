defmodule Mix.Tasks.Simulation do
  use Mix.Task
  alias Dl44.Simulation

  def run(args) do
    options = [switches: [output: :string], aliases: [o: :output]]
    {opts, _, _} = OptionParser.parse(args, options)

    [output: outfile] = opts

    ppm = Simulation.run

    File.write!(outfile, ppm)
  end
end

