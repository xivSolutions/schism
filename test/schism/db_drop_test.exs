# defmodule Schism.DbDropTest do
#   use ExUnit.Case
#   import Schism

#   @db_name "temp01"

#   setup do
#     # make sure there's a db present before the test runs:
#     res = create_db @db_name

#     {:ok, res: res}
#   end

#   test "drops temp database in pg" do
#     {:ok, success} =  drop_db @db_name
#     {:ok, exists} =  db_exists @db_name
#     assert success == true && exists == false
#   end

# end
