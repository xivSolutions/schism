# defmodule Schism.Test do
#   use ExUnit.Case
#   import Schism
#   import Schism.PsqlRunner


#   @db_name "temp01"
#   @test_script_path "test/db/test_read.sql"
#   @test_table_name "artists"
#   @test_sql "create table if not exists #{@test_table_name} (id serial primary key, name text not null);"

#   setup_all do

#     # drop_db(@db_name)

#     # make sure the test file exists before the run:
#     {:ok, file} = File.open @test_script_path, [:write]
#     IO.binwrite file, @test_sql
#     File.close file

#     # make sure temp db existss before test run:
#     # {:ok, deployed} = @db_name |> create_db
#     deployed = true
#     # read script from file:
#     file_content = read_sql_file(@test_script_path)

#     # clean up after the test runs
#     on_exit fn ->
#       # File.rm @test_script_path
#     end

#     {:ok, deploy_successful: deployed, script: file_content}
#   end

#   test "deploys temp db", %{deploy_successful: deployed} do
#     assert deployed == true
#   end


#   test "reads script from file", %{script: file_content} do
#     assert file_content == @test_sql
#   end

#   # test "executes create table script", %{script: file_content} do
#   #   run file_content, db: @db_name
#   #   sql = "select count(*) as ct from information_schema.tables where table_name = '#{@test_table_name}';"

#   #   {:ok, res} = run(sql, [db: @db_name, output_type: :int])
#   #   assert res  > 0
#   # end

#   test "reads schema from db", %{script: file_content} do
#     {:ok, res} = get_schema_dump @db_name
#     assert res == "XX"
#   end

# end