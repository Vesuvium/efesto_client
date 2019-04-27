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

  def read(endpoint) do
    case Tesla.get(endpoint) do
      {:ok, response} ->
        response

      {:error, error} ->
        error
    end
  end

  def write(endpoint, data) do
    case Tesla.post(endpoint, data) do
      {:ok, response} ->
        response

      {:error, error} ->
        error
    end
  end
end
