defmodule EfestoClientTest do
  use ExUnit.Case
  import Dummy

  alias EfestoClient.Body

  test "the headers function" do
    assert EfestoClient.headers("token") == [{"Authorization", "Bearer token"}]
  end

  test "the headers function with nil" do
    assert EfestoClient.headers(nil) == []
  end

  test "the read function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, [_query, _headers] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"get", mock}] do
        result = EfestoClient.read("/endpoint")
        assert called(EfestoClient.get("/endpoint", query: [], headers: nil))
        assert called(EfestoClient.headers(nil))
        assert called(Body.parse("hello"))
        assert result == "hello"
      end
    end
  end

  test "the read function with a query" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, [_query, _headers] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"get", mock}] do
        EfestoClient.read("/endpoint", "query")
        assert called(EfestoClient.get("/endpoint", query: "query", headers: nil))
      end
    end
  end

  test "the read function with a token" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, [_query, _headers] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"get", mock}] do
        EfestoClient.read("/endpoint", [], "token")
        assert called(EfestoClient.headers("token"))
      end
    end
  end

  test "the read function when getting an error" do
    get = fn _x, [_query, _headers] -> {:error, "error"} end

    dummy EfestoClient, [{"get", get}] do
      assert EfestoClient.read("/endpoint") == "error"
    end
  end

  test "the write function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, _y, [_token] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"post", mock}] do
        result = EfestoClient.write("/endpoint", "data")
        assert called(EfestoClient.post("/endpoint", "data", headers: nil))
        assert called(Body.parse("hello"))
        assert result == "hello"
      end
    end
  end

  test "the write function with a token" do
    response = response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, _y, [_token] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"post", mock}] do
        EfestoClient.write("/endpoint", "data", "token")
        assert called(EfestoClient.headers("token"))
      end
    end
  end

  test "the write function when getting an error" do
    dummy EfestoClient, [{"post", fn _x, _y, [_token] -> {:error, "error"} end}] do
      assert EfestoClient.write("/endpoint", "data") == "error"
    end
  end

  test "the edit function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, _y, [_token] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"patch", mock}] do
        result = EfestoClient.edit("/endpoint", "data")
        assert called(EfestoClient.patch("/endpoint", "data", headers: nil))
        assert called(Body.parse("hello"))
        assert result == "hello"
      end
    end
  end

  test "the edit function with a token" do
    response = response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, _y, [_token] -> response end

    dummy Body, ["parse"] do
      dummy EfestoClient, ["headers", {"patch", mock}] do
        EfestoClient.edit("/endpoint", "data", "token")
        assert called(EfestoClient.headers("token"))
      end
    end
  end

  test "the destroy function" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}
    mock = fn _x, [_token] -> response end

    dummy EfestoClient, ["headers", {"delete", mock}] do
      result = EfestoClient.destroy("/endpoint")
      assert called(EfestoClient.delete("/endpoint", headers: nil))
      assert result == :ok
    end
  end

  test "the destroy function with a token" do
    response = {:ok, %Tesla.Env{status: 204, body: nil}}
    mock = fn _x, [_token] -> response end

    dummy EfestoClient, ["headers", {"delete", mock}] do
      EfestoClient.destroy("/endpoint", "token")
      assert called(EfestoClient.headers("token"))
    end
  end
end
