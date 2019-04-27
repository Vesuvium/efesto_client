defmodule EfestoClient.BodyTest do
  use ExUnit.Case

  alias EfestoClient.Body

  test "parsing a body" do
    assert Body.parse(%{}) == %{}
  end

  test "parsing a body with properties" do
    result = Body.parse(%{"properties" => %{"key" => "value"}})
    assert result == %{"key" => "value"}
  end
end
