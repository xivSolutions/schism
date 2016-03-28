defmodule Schism.SqlPaserTest do
  use ExUnit.Case
  import Schism
  import Schism.SqlParser

  # tests depend on a specific script present at this path:
  @temp_script_path "test/db/script_parse_test.sql"

  setup_all do

    # read script from file:
    dump_file_content = read_sql_file(@temp_script_path)
    {:ok, script: dump_file_content}
  end



  test "strips comments and whitespace" do
    test_string = "-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: \n--\n\nCOMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';\n\n\nSET search_path = myschema, pg_catalog;\n\nSET default_tablespace = '';\n\nSET default_with_oids = false;\n\n--\n-- Name: some_table; Type: TABLE; Schema: myschema; Owner: postgres\n--\n\nCREATE TABLE some_table (\n    id integer NOT NULL,\n    some_name text\n);\n"
    x = test_string 
    |> strip_comments_and_whitespace
    assert x == "COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language'; SET search_path = myschema, pg_catalog; SET default_tablespace = ''; SET default_with_oids = false; CREATE TABLE some_table ( id integer NOT NULL, some_name text );"
  end


  test "groups schema create statements as list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace
    |> get_create_schema_statements

    assert res == ["CREATE SCHEMA schema_one;", "CREATE SCHEMA schema_two;"]
  end 

  test "groups schema alter statements as list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace
    |> get_alter_schema_statements

    assert res == ["ALTER SCHEMA schema_one OWNER TO \"xivSolutions\";", "ALTER SCHEMA schema_two OWNER TO \"xivSolutions\";"]
  end 

  test "groups extension create statements as list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace
    |> get_create_extension_statements

    assert res == ["CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;", "CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;"]
  end 


  test "groups schema operations using search_path", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_search_path_groups res
    first = Enum.at(list, 0)
    second = Enum.at(list, 1)

    assert Enum.count(list) > 0 
      && String.starts_with?(first, "SET search_path = public") 
      && String.starts_with?(second, "SET search_path = schema_one") 
  end


  test "groups table create statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_create_table_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "CREATE TABLE") 
  end


  test "groups table alter statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_alter_table_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "ALTER TABLE") 
  end


  test "groups function create statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_create_function_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "CREATE FUNCTION") 
  end


  test "groups function alter statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_alter_function_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "ALTER FUNCTION") 
  end

  test "groups view create statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_create_view_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "CREATE VIEW") 
  end



  test "groups sequence create statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_create_sequence_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "CREATE SEQUENCE") 
  end

  test "groups sequence alter statements into list", %{script: dump_file_content} do
    res = dump_file_content
    |> strip_comments_and_whitespace

    list = get_alter_sequence_statements res
    first = Enum.at(list, 0)
    assert Enum.count(list) > 0 && String.starts_with?(first, "ALTER SEQUENCE") 
  end

end