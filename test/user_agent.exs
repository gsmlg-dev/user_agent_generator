defmodule UserAgentTest do
  use ExUnit.Case, async: true

  import UserAgent
  doctest UserAgent

  test "Test random" do
    assert is_binary(UserAgent.random()) == true
  end

  test "Test random_all" do
    assert is_binary(UserAgent.random_all()) == true
  end
end
