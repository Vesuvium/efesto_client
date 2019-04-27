defmodule EfestoClient do
  @moduledoc """
  Client for Efesto
  """
  use Tesla

  def read(endpoint) do
    case Tesla.get(endpoint) do
      {:ok, response} ->
        response

      {:error, error} ->
        error
    end
  end
end
