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

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy Body, ["parse"] do
        dummy EfestoClient, ["headers"] do
          result = EfestoClient.read("/endpoint")
          assert called(Tesla.get("/endpoint", query: [], headers: nil))
          assert called(EfestoClient.headers(nil))
          assert called(Body.parse("hello"))
          assert result == "hello"
        end
      end
    end
  end

  test "the read function with a query" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy Body, ["parse"] do
        dummy EfestoClient, ["headers"] do
          EfestoClient.read("/endpoint", "query")
          assert called(Tesla.get("/endpoint", query: "query", headers: nil))
        end
      end
    end
  end

  test "the read function with a token" do
    response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"get", fn _x, [_query, _headers] -> response end}] do
      dummy Body, ["parse"] do
        dummy EfestoClient, ["headers"] do
          EfestoClient.read("/endpoint", [], "token")
          assert called(EfestoClient.headers("token"))
        end
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

    dummy Tesla, [{"post", fn _x, _y, [_token] -> response end}] do
      dummy Body, ["parse"] do
        dummy EfestoClient, ["headers"] do
          result = EfestoClient.write("/endpoint", "data")
          assert called(Tesla.post("/endpoint", "data", headers: nil))
          assert called(Body.parse("hello"))
          assert result == "hello"
        end
      end
    end
  end

  test "the write function with a token" do
    response = response = {:ok, %Tesla.Env{status: 200, body: "hello"}}

    dummy Tesla, [{"post", fn _x, _y, [_token] -> response end}] do
      dummy Body, ["parse"] do
        dummy EfestoClient, ["headers"] do
          EfestoClient.write("/endpoint", "data", "token")
          assert called(EfestoClient.headers("token"))
        end
      end
    end
  end

  test "the write function when getting an error" do
    dummy Tesla, [{"post", fn _x, _y, [_token] -> {:error, "error"} end}] do
      assert EfestoClient.write("/endpoint", "data") == "error"
    end
  end
end
