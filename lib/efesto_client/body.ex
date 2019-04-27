defmodule EfestoClient.Body do
  def parse(body) do
    cond do
      body["properties"] ->
        body["properties"]

      true ->
        body
    end
  end
end
