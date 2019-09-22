defmodule EfestoClient do
  @moduledoc """
  Client for Efesto
  """
  use Tesla
  plug(Tesla.Middleware.BaseUrl, Confex.get_env(:efesto_client, :api_url))
  plug(Tesla.Middleware.JSON)

  alias EfestoClient.Body

  def headers(token) do
    if token do
      [{"authorization", "Bearer #{token}"}]
    else
      [{"authorization", "Bearer #{Confex.get_env(:efesto_client, :token)}"}]
    end
  end

  def read(endpoint, query \\ [], token \\ nil) do
    headers = EfestoClient.headers(token)

    case EfestoClient.get(endpoint, query: query, headers: headers) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def write(endpoint, data, token \\ nil) do
    headers = EfestoClient.headers(token)

    case EfestoClient.post(endpoint, data, headers: headers) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def edit(endpoint, data, token \\ nil) do
    headers = EfestoClient.headers(token)

    case EfestoClient.patch(endpoint, data, headers: headers) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def destroy(endpoint, token \\ nil) do
    headers = EfestoClient.headers(token)

    case EfestoClient.delete(endpoint, headers: headers) do
      {:ok, _response} ->
        :ok

      {:error, error} ->
        error
    end
  end
end
