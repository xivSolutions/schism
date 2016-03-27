# defmodule Schism.DbCreateTest do
#   use ExUnit.Case
#   import Schism

#   @db_name "temp01"

#   setup do
#     # make sure there's no db present before the test runs:
#     res = cleanup

#     # clean up after the test runs
#     on_exit fn ->
#       cleanup
#     end

#     {:ok, res: res}
#   end

#   defp cleanup do
#       drop_db @db_name
#   end

#   test "existence check returns false when db does not exists" do
#     {:ok, res} =  db_exists @db_name
#     assert res == false
#   end

#   test "creates temp database in pg" do
#     {:ok, success} =  create_db @db_name
#     {:ok, exists} =  db_exists @db_name
#     assert success == true && exists == true
#   end

# end
