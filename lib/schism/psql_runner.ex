defmodule Schism.PsqlRunner do

  def run_with_psql(sql, opts) do
    db = opts[:database] || opts[:db]
    args = ["-d", db, "-c", sql, "--quiet", "--set", "ON_ERROR_STOP=1", "--no-psqlrc"]
    System.cmd "psql", args
  end

end