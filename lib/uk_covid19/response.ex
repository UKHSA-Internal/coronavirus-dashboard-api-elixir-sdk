defmodule UkCovid19.Response do
  defstruct [:data, :length, :last_update, :total_pages]

  @type t :: %__MODULE__{
          length: integer(),
          last_update: String.t(),
          total_pages: integer(),
          data: Enum.t()
        }
end
