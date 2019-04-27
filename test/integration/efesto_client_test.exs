defmodule EfestoClientIntegrationTest do
  use ExUnit.Case

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "http://localhost:5000/url"} ->
        %Tesla.Env{status: 200, body: "hello"}

      %{method: :get, url: "http://localhost:5000/json"} ->
        json(%{"json" => "yes"})
    end)

    :ok
  end

  test "the base url should be loaded from Confex" do
    {:ok, response} = EfestoClient.get("/url")
    assert response.body == "hello"
  end

  test "json should be plugged" do
    {:ok, response} = EfestoClient.get("/json")
    assert response.body == %{"json" => "yes"}
  end
end
