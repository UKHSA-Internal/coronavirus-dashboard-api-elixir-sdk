# UkCovid19Sdk

## Software Development Kit (SDK) for Elixir

This is a Elixir SDK for the COVID-19 API, as published by Public Health England on [Coronavirus (COVID-19) in the UK](https://coronavirus.data.gov.uk/).

The API supplies the latest data for the COVID-19 outbreak in the United Kingdom.

The endpoint for the data provided using this SDK is:

https://api.coronavirus.data.gov.uk/v1/data

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `uk_covid19_sdk` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:uk_covid19_sdk, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/uk_covid19_sdk](https://hexdocs.pm/uk_covid19_sdk).
