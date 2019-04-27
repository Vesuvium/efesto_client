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
      [{"Authorization", "Bearer #{token}"}]
    else
      []
    end
  end

  def read(endpoint, query \\ [], token \\ nil) do
    headers = EfestoClient.headers(token)

    case Tesla.get(endpoint, query: query, headers: headers) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def write(endpoint, data, token \\ nil) do
    case Tesla.post(endpoint, data, headers: EfestoClient.headers(token)) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def edit(endpoint, data, token \\ nil) do
    case Tesla.patch(endpoint, data, headers: EfestoClient.headers(token)) do
      {:ok, response} ->
        Body.parse(response.body)

      {:error, error} ->
        error
    end
  end

  def destroy(endpoint, token \\ nil) do
    case Tesla.delete(endpoint, headers: EfestoClient.headers(token)) do
      {:ok, _response} ->
        :ok

      {:error, error} ->
        error
    end
  end
end
