defmodule UkCovid19.Request do
  @moduledoc """
  ## Request module

  Passed as a parameter in UkCovid19.Client
  """
  defstruct [:filters, :structure, :latest_by, format: :json]

  @type format :: :csv | :json | :xml

  @type latest_by :: String.t() | nil

  @type t :: %__MODULE__{
          format: format(),
          filters: list(),
          structure: map(),
          latest_by: latest_by()
        }
end
