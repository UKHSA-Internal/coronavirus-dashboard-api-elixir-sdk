defmodule UkCovid19.Client do
  alias UkCovid19.Request
  alias UkCovid19.Response

  @endpoint "https://api.coronavirus.data.gov.uk/v1/data"
  @options [recv_timeout: 10000]

  def endpoint, do: @endpoint

  @spec get(%Request{}) :: %Response{}
  def get(request) do
    response = get_paged_data(request)

    %Response{
      length: length(response.data),
      last_update: response.last_update,
      total_pages: response.total_pages,
      data: response.data
    }
  end

  @spec head(%Request{}) :: map()
  def head(request) do
    response = HTTPoison.head!(build_request(request), [], @options)
    Enum.into(response.headers, %{})
  end

  @spec options :: map()
  def options do
    response = HTTPoison.options!(@endpoint, [], @options)
    parse_body(response.body)
  end

  @spec build_request(%Request{}) :: String.t()
  def build_request(request) do
    filters = request.filters |> Enum.join(";")

    structure =
      request.structure
      |> Enum.map_intersperse(",", fn {k, v} -> "\"#{k}\":\"#{v}\"" end)

    latest_by =
      if request.latest_by == nil do
        ""
      else
        "&latestby=#{request.latest_by}"
      end

    @endpoint <>
      "?filters=#{filters}&structure={#{structure}}#{latest_by}" <>
      "&format=#{Atom.to_string(request.format)}"
  end

  defp get_paged_data(request) do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(%Response{data: []}, fn i, acc ->
      response = send_get_request(request, i)

      if response.status_code != 200 do
        {:halt, acc}
      else
        gzip? =
          Enum.any?(response.headers, fn {name, value} ->
            :hackney_bstr.to_lower(name) == "content-encoding" &&
              :hackney_bstr.to_lower(value) == "gzip"
          end)

        body = if gzip?, do: :zlib.gunzip(response.body), else: response.body
        data = parse_body(body)
        headers = Enum.into(response.headers, %{})
        last_update = headers["Last-Modified"]

        acc = %Response{
          acc
          | data: acc.data ++ data["data"],
            total_pages: i,
            last_update: last_update
        }

        {:cont, acc}
      end
    end)
  end

  defp send_get_request(request, current_page) do
    HTTPoison.get!(build_request(request) <> "&page=#{current_page}", [], @options)
  end

  defp parse_body(body) do
    body
    |> Poison.decode!()
  end
end
