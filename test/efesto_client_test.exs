defmodule EfestoClientTest do
  use ExUnit.Case
  import Dummy

  test "the read function" do
    dummy Tesla, [{"get", fn _x -> {:ok, "body"} end}] do
      result = EfestoClient.read("/endpoint")
      assert called(Tesla.get("/endpoint"))
      assert result == "body"
    end
  end

  test "the read function when getting an error" do
    dummy Tesla, [{"get", fn _x -> {:error, "error"} end}] do
      assert EfestoClient.read("/endpoint") == "error"
    end
  end

  test "the write function" do
    dummy Tesla, [{"post", fn _x, _y -> {:ok, "body"} end}] do
      result = EfestoClient.write("/endpoint", "data")
      assert called(Tesla.post("/endpoint", "data"))
      assert result == "body"
    end
  end

  test "the write function when getting an error" do
    dummy Tesla, [{"post", fn _x, _y -> {:error, "error"} end}] do
      assert EfestoClient.write("/endpoint", "data") == "error"
    end
  end
end
