defmodule EfestoClientTest do
  use ExUnit.Case
  doctest EfestoClient

  test "greets the world" do
    assert EfestoClient.hello() == :world
  end
end
