defmodule EfestoClient do
  @moduledoc """
  Client for Efesto
  """
  use Tesla

  def parse_properties(properties) do
    properties
  end

  def parse_body(body) do
    body
  end

  def headers(token) do
    if token do
      [{"Authorization", "Bearer #{token}"}]
    else
      []
    end
  end

  def read(endpoint, query \\ [], token \\ nil) do
    headers = EfestoClient.headers(token)

    case Tesla.get(endpoint, query: query, headers: headers) do
      {:ok, response} ->
        EfestoClient.parse_body(response.body)

      {:error, error} ->
        error
    end
  end

  def write(endpoint, data) do
    case Tesla.post(endpoint, data) do
      {:ok, response} ->
        EfestoClient.parse_body(response.body)

      {:error, error} ->
        error
    end
  end
end
