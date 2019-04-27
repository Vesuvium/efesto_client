defmodule EfestoClient.Body do
  defp parse_entities(entities) do
    Enum.map(entities, fn entity ->
      entity["properties"]
    end)
  end

  def parse(body) do
    cond do
      body["properties"] ->
        body["properties"]

      body["entities"] ->
        parse_entities(body["entities"])

      true ->
        body
    end
  end
end
