# Coronavirus (COVID-19) in the UK - API Service

## Software Development Kit (SDK) for Elixir

This is an Elixir SDK for the COVID-19 API, as published by Public Health England on [Coronavirus (COVID-19) in the UK](https://coronavirus.data.gov.uk/).


### SDK for other languages

Similar libraries are also available for [Python](https://github.com/publichealthengland/coronavirus-dashboard-api-python-sdk), [JavaScript](https://github.com/publichealthengland/coronavirus-dashboard-api-javascript-sdk), [R](https://github.com/publichealthengland/coronavirus-dashboard-api-R-sdk), and [.Net](https://github.com/publichealthengland/coronavirus-dashboard-api-net-sdk).


## The API

The API supplies the latest data for the COVID-19 outbreak in the United Kingdom. The
endpoint for the data provided using this SDK is:

```
https://api.coronavirus.data.gov.uk/v1/data
```

See the [Developers Guide](https://coronavirus.data.gov.uk/developers-guide) for additional information on the API and see a list of
latest metrics.


### Pagination

The API responses are restricted to 1000 records per request. If you need more records,
you will need to use the ``page`` query parameter to enable pagination.

As a bonus, the SDKs come with a built-in mechanism to bypass pagination restrictions in
the API and produce the entire data for a given combination of ``filters`` and
``structure`` in one go.

When accessing the API through one of the SDKs, you will always download the entire
dataset unless the ``latest_by`` argument is defined.



## Getting started

### Installation

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


-----------

This library is a contribution by [Callum Vass](https://github.com/CallumVass). 

Maintained by `Public Health England`_.

Copyright (c) 2020, Public Health England.

