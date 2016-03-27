defmodule Schism do
  import Schism.PsqlRunner

  # def main(args) do
  #   IO.puts args |> parse_args
  # end

  # defp parse_args(args) do
  #   options = OptionParser.parse(args)
  #   case options do
  #     {[name: name], _, _} -> IO.puts "Hello, #{name}!"
  #   end
  # end

  def read_sql_file(file) do
    #find the DB dir
    sql = File.read!(file)
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
    # System.cmd("psql", ["-U", "postgres", "-c", "drop database #{name}"])
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

  def create_pg_script(input_script) do
    temp_db = "temp_001"
    drop_db temp_db
    create_db temp_db
    run input_script, db: temp_db
    get_schema_dump(temp_db)
  end

end
