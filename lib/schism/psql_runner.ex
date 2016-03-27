defmodule Schism.PsqlRunner do

  # def run_with_psql(sql, opts) do
  #   db = opts[:database] || opts[:db]
  #   args = ["-d", db, "-c", sql, "--quiet", "--set", "ON_ERROR_STOP 1", "--no-psqlrc", "--no-align", "--tuples-only"]
  #   System.cmd("psql", args, stderr_to_stdout: true)
  #   |> case do
  #     {res, 0} -> {:ok, res |> String.strip}
  #     {res, _} -> {:error, res}
  #   end
  # end

  def run(sql, opts)do
    db = opts[:database] || opts[:db]
    output_def = opts[:output_type]
    args = ["-d", db, "-c", sql, "--quiet", "--set", "ON_ERROR_STOP 1", "--no-psqlrc", "--no-align", "--tuples-only"]
    System.cmd("psql", args, stderr_to_stdout: true)
    |> case do
      {res, 0} -> {:ok, res |> resolve_result output_def}
      {res, _} -> {:error, res}
    end
  end

  def resolve_result(result, output_def) do
    case output_def do
      :int -> result |> String.strip |> String.to_integer
      :float -> result |> String.strip |> String.to_float
      _ -> result |> String.strip
    end
  end





end


