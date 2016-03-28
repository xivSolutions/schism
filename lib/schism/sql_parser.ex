defmodule Schism.SqlParser do 

  # SET (?!search_path).+(?<=;) anything but search_path
  # (?=SET default_tablespace).+?(?<=;)

  def strip_comments_and_whitespace(script) do
    # these need to be done in order - comments first, then whitespace:
    script |> strip_comments |> strip_whitespace
  end

  def get_search_path_groups(script) do
    regex = ~r/(SET search_path).+?(?=SET search_path)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  # do this within each search path group:
  def get_default_tablespace(script) do
    regex = ~r/(?=SET default_tablespace).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  # do this within each search path group:
  def get_default_with_oids(script) do
    regex = ~r/(?=SET default_with_oids).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_create_schema_statements(script) do
    regex = ~r/(?=CREATE SCHEMA).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_alter_schema_statements(script) do
    regex = ~r/(?=ALTER SCHEMA).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_create_extension_statements(script) do
    regex = ~r/(?=CREATE EXTENSION).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end



  def get_create_table_statements(script) do
    regex = ~r/(?=CREATE TABLE).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_alter_table_statements(script) do
    regex = ~r/(?=ALTER TABLE).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end



  def get_create_function_statements(script) do
    regex = ~r/(?=(CREATE FUNCTION|CREATE OR REPLACE FUNCTION)).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_alter_function_statements(script) do
    regex = ~r/(?=ALTER FUNCTION).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end



  def get_create_view_statements(script) do
    regex = ~r/(?=(CREATE VIEW|CREATE OR REPLACE VIEW)).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_alter_view_statements(script) do
    regex = ~r/(?=ALTER VIEW).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end



  def get_create_sequence_statements(script) do
    regex = ~r/(?=CREATE SEQUENCE).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end

  def get_alter_sequence_statements(script) do
    regex = ~r/(?=ALTER SEQUENCE).+?(?<=;)/i
    Regex.scan(regex, script, capture: :first)
    |> List.flatten
  end



  defp strip_comments(script) do
    regex = ~r/(?=--).+/
    String.replace(script, regex, "")
  end

  defp strip_whitespace(script) do
    regex = ~r/\s+/
    String.replace(script, regex, " ") 
    |> String.strip
  end


end