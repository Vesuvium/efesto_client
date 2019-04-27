defmodule EfestoClient.BodyTest do
  use ExUnit.Case

  alias EfestoClient.Body

  test "parsing a body" do
    assert Body.parse("body") == "body"
  end
end
