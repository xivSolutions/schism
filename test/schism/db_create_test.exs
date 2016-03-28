defmodule Schism.DbCreateTest do
  use ExUnit.Case
  import Schism.PsqlRunner

  @db_name "test_create_temp_destroy_me"

  setup do
    # make sure there's no db present before the test runs:
    dropped = cleanup

    # clean up after the test runs
    on_exit fn ->
      cleanup
    end

    {:ok, dropped: dropped}
  end

  defp cleanup do
      drop_db @db_name
  end

  test "existence check returns false when db does not exists" do
    {:ok, res} =  db_exists @db_name
    assert res == false
  end

  test "creates temp database in pg" do
    {:ok, success} =  create_db @db_name
    {:ok, exists} =  db_exists @db_name
    assert success == true && exists == true
  end

end
