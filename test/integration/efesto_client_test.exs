defmodule EfestoClientIntegrationTest do
  use ExUnit.Case

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "http://localhost:5000/test"} ->
        %Tesla.Env{status: 200, body: "hello"}
    end)

    :ok
  end

  test "the base url should be loaded from Confex" do
    {:ok, response} = EfestoClient.get("/test")
    assert response.body == "hello"
  end
end
