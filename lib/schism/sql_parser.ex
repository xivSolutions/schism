defmodule Schism.SqlParser do 

  @create_table_regex "(?=CREATE TABLE).+?(?<=;)/i"
  @alter_table_regex "(?=ALTER TABLE).+?(?<=;)/i"

  @create_sequence_regex "(?=CREATE SEQUENCE).+?(?<=;)/i"
  @alter_sequence_regex "(?=ALTER SEQUENCE).+?(?<=;)/i"


  # def capture_create_table(script) do
  #   regex = ~r/(?=ALTER TABLE).+?(?<=;)/i/
  #   Regex.scan(regex, script)

  # end

  def strip_comments_and_whitespace(script) do
    # these need to be done in order - comments first, then whitespace:
    script |> strip_comments |> strip_whitespace
  end

  def get_search_path_groups(script) do
    regex = ~r/(SET search_path).+?(?=SET search_path)/i
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






 #regex sample: (?=SET search_path).* needs more
 #regex sample: match commented lines (?=--).+
end