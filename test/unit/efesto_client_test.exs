defmodule EfestoClientTest do
  use ExUnit.Case
  import Dummy

  test "the parse_properties function" do
    assert EfestoClient.parse_properties(%{key: "value"}) == %{key: "value"}
  end

  test "the parse_body function" do
    assert EfestoClient.parse_body("body") == "body"
  end

  test "the headers function" do
    assert EfestoClient.headers("token") == [{"Authorization", "Bearer token"}]
  end

  test "the headers function with nil" do
    assert EfestoClient.headers(nil) == []
  end

  test "the read function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy EfestoClient, ["parse_body", "headers"] do
        result = EfestoClient.read("/endpoint")
        assert called(Tesla.get("/endpoint", query: [], headers: nil))
        assert called(EfestoClient.headers(nil))
        assert called(EfestoClient.parse_body("hello"))
        assert result == "hello"
      end
    end
  end

  test "the read function with a query" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy EfestoClient, ["parse_body", "headers"] do
        EfestoClient.read("/endpoint", "query")
        assert called(Tesla.get("/endpoint", query: "query", headers: nil))
      end
    end
  end

  test "the read function with a token" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy EfestoClient, ["parse_body", "headers"] do
        EfestoClient.read("/endpoint", [], "token")
        assert called(EfestoClient.headers("token"))
      end
    end
  end

  test "the read function when getting an error" do
    get = fn _x, [_query, _headers] -> {:error, "error"} end

    dummy Tesla, [{"get", get}] do
      assert EfestoClient.read("/endpoint") == "error"
    end
  end

  test "the write function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"post", fn _x, _y -> response end}] do
      dummy EfestoClient, ["parse_body"] do
        result = EfestoClient.write("/endpoint", "data")
        assert called(Tesla.post("/endpoint", "data"))
        assert called(EfestoClient.parse_body("hello"))
        assert result == "hello"
      end
    end
  end

  test "the write function when getting an error" do
    dummy Tesla, [{"post", fn _x, _y -> {:error, "error"} end}] do
      assert EfestoClient.write("/endpoint", "data") == "error"
    end
  end
end
