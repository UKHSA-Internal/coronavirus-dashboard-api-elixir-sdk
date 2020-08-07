defmodule UkCovid19SdkTest do
  use ExUnit.Case
  doctest UkCovid19Sdk

  test "greets the world" do
    assert UkCovid19Sdk.hello() == :world
  end
end
