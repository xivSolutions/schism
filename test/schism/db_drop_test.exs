defmodule Schism.DbDropTest do
  use ExUnit.Case
  import Schism.PsqlRunner

  @db_name "test_drop_temp_destroy_me"

  setup do
    # make sure there's a db present before the test runs:
    created = create_db @db_name

    {:ok, res: created}
  end

  test "drops temp database in pg" do
    {:ok, success} =  drop_db @db_name
    {:ok, exists} =  db_exists @db_name
    assert success == true && exists == false
  end

end
