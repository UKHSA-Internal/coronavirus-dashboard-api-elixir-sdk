defmodule UkCovid19.Response do
  @moduledoc """

  ## Response module

  Response received back from `UkCovid19.Client.get/1`
  """
  defstruct [:data, :length, :last_update, :total_pages]

  @typedoc """
  #### length:

  #### last_update:
    Produces the timestamp for the last update in GMT.

    This property supplies the API time - i.e. the time at which the data were
    deployed to the database. Please note that there will always be a difference
    between this time and the timestamp that is displayed on the website, which may
    be accessed via the ``.get_release_timestamp()`` method. The website timestamp
    signifies the time at which the data were release to the API, and by extension
    the website.

  ##### note:
    The output is extracted from the header and is accurate to the second.
  ##### warning:
    The ISO-8601 standard requires a ``"Z"`` character to be added to the end of the timestamp.
    This is a timezone feature and is not recognised by Python's ``datetime`` library.
    It is, however, most other libraries; e.g. ``pandas``.
    If you wish to parse the timestamp using the the ``datetime`` library,
    make sure that you remove the trailing ``"Z"`` character.
  """
  @type t :: %__MODULE__{
          length: integer(),
          last_update: String.t(),
          total_pages: integer(),
          data: Enum.t()
        }
end
