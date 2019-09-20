defmodule Scrybot.Scryfall do
  use HTTPoison.Base
  @expected_fields ~w(
    name image_uris oracle_text scryfall_uri
  )

  def process_request_url url do
    "https://api.scryfall.com/cards/named?fuzzy=" <> url
  end

  def process_response_body body do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
