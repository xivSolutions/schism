defmodule SchismTest do
  use ExUnit.Case
  import Schism.PsqlRunner
  import Schism

  @schema_path "test/db/schema.sql"

  test "reads files from disk" do
    sql = read_sql_file @schema_path
    assert String.length(sql) > 0
  end
end
