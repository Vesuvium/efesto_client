defmodule EfestoClient.Body do
  defp parse_properties(properties) do
    Enum.reduce(properties, %{}, fn {key, value}, acc ->
      if is_list(value) do
        Map.put(acc, key, parse_entities(value))
      else
        Map.put(acc, key, value)
      end
    end)
  end

  defp parse_entities(entities) do
    Enum.map(entities, fn entity ->
      parse_properties(entity["properties"])
    end)
  end

  def parse(body) do
    cond do
      body["properties"] ->
        parse_properties(body["properties"])

      body["entities"] ->
        parse_entities(body["entities"])

      true ->
        body
    end
  end
end
