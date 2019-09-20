defmodule Scrybot do
  use Application
  def start(_, _) do
    Scrybot.Supervisor.start_link
  end
  def fetch_card name do
    Scrybot.Scryfall.get!(name)
      |> handle_response
      |> case do
      {:ok, res} -> res
        |> get_body
        |> extract_info
      {:error, res} -> res
    end
  end

  def get_body res do
    Map.get(res, :body)
  end

  def get_image card do
    Keyword.get(card, :image_uris)
      |> Map.get("large")
  end

  def get_oracle_text card do
    Keyword.get(card, :oracle_text)
  end

  def get_name card do
    Keyword.get(card, :name)
  end

  def get_uri card do
    Keyword.get(card, :scryfall_uri)
  end

  def extract_info card do
    %{name: get_name(card), img: get_image(card), uri: get_uri(card), text: get_oracle_text(card)}
    |> Enum.map_join("\n", fn {_, v} -> v end)
  end

  def handle_response res do
    case res.status_code do
      200 -> {:ok, res}
      404 -> {:error, "Scryfall couldn't find any card using that query! Please try again with a different query."}
      _ -> {:error, "Something went wrong. Please try again or contact the developer for details. The developer is probably just not great at this."}
    end
  end
end
