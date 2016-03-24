defmodule Schism do
  def hello(args) do
    IO.puts args
  end

  def main(args) do
    IO.puts args |> parse_args
  end

  defp parse_args(args) do
    options = OptionParser.parse(args)
    case options do
      {[name: name], _, _} -> IO.puts "Hello, #{name}!"
    end
  end

  def read_sql_file(file) do
    #find the DB dir
    sql = File.read!(file)
  end
end
