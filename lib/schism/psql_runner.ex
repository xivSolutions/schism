defmodule Schism.PsqlRunner do

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

  defp resolve_result(result, output_def) do
    case output_def do
      :int -> result |> String.strip |> String.to_integer
      :float -> result |> String.strip |> String.to_float
      _ -> result |> String.strip
    end
  end

  def create_db(name) do
    System.cmd("createdb", [name], stderr_to_stdout: true)
    |> case do
      {res, 0} ->  {:ok, true}
      {res, _} -> {:error, res}
    end
  end

  def drop_db(name) do 
    System.cmd("dropdb", ["--if-exists", name], stderr_to_stdout: true)
    |> case do
      {res, 0} ->  {:ok, true}
      {res, _} -> {:error, res}
    end
  end

  def db_exists(name) do
    sql = "select coalesce ((select 1 from pg_database where datname='#{name}'), 0)"
    System.cmd("psql", ["-t", "-A", "-c", sql], stderr_to_stdout: true)
    |> case do
      {res, 0} -> {:ok, res |> String.strip |> String.to_integer > 0}
      {res, _} -> {:error, res}
    end
  end

  def get_schema_dump(dbname) do
    System.cmd("pg_dump", ["-d", dbname, "--schema-only"], stderr_to_stdout: true)
    |> case do
      {res, 0} -> {:ok, res}
      {res, _} -> {:error, res}
    end
  end





end


