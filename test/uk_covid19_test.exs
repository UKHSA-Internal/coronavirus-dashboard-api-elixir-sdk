defmodule UkCovid19Test do
  use ExUnit.Case

  alias UkCovid19.Request
  alias UkCovid19.Client

  describe "api_params" do
    test "build_request integrity" do
      request = request()

      filters = request.filters |> Enum.join(";")

      structure =
        request.structure
        |> Enum.map_intersperse(",", fn {k, v} ->
          "\"#{k}\":\"#{v}\""
        end)

      should_be = Client.endpoint() <> "?filters=#{filters}&structure={#{structure}}&format=json"

      assert Client.build_request(request) == should_be
    end
  end

  describe "head" do
    test "head integrity" do
      response = Client.head(request())

      assert Map.has_key?(response, "Content-Location")
    end
  end

  describe "get" do
    test "get integrity" do
      response = Client.get(request())

      assert Map.has_key?(response, :data)
      assert Map.has_key?(response, :last_update)
      assert Map.has_key?(response, :length)
      assert Map.has_key?(response, :total_pages)

      assert {:ok, _} = Timex.parse(response.last_update, "{RFC1123}")
      assert response.total_pages == 1
      assert response.length > 10

      [head | _] = response.data

      for {k, _} <- structure() do
        assert Map.has_key?(head, Atom.to_string(k))
      end
    end
  end

  describe "options" do
    test "options integrity" do
      response = Client.options()

      servers = Map.get(response, "servers")

      assert servers != nil

      [head | _] = servers

      assert Client.endpoint() == head["url"]
    end
  end

  describe "latest_by" do
    test "latest_by integrity" do
      request = request()

      request = %Request{
        request
        | latest_by: "newCasesBySpecimenDate"
      }

      response = Client.get(request)

      assert Map.has_key?(response, :data)
      assert Map.has_key?(response, :last_update)
      assert Map.has_key?(response, :length)
      assert Map.has_key?(response, :total_pages)

      assert {:ok, _} = Timex.parse(response.last_update, "{RFC1123}")
      assert response.total_pages == 1
      assert response.length == 1

      [head | _] = response.data

      for {k, _} <- structure() do
        assert Map.has_key?(head, Atom.to_string(k))
      end
    end
  end

  defp structure,
    do: %{
      name: "areaName",
      date: "date",
      newCases: "newCasesBySpecimenDate"
    }

  defp request,
    do: %Request{
      filters: ["areaType=ltla", "areaName=adur"],
      structure: structure()
    }
end
