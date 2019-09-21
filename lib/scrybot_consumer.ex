defmodule Scrybot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event {:MESSAGE_CREATE, msg, _} do
    case msg.content do
      "!card " <> name ->
        card = name
          |> String.replace(" ", "+")
          |> String.replace(~r(\r|\n), "")
          |> Scrybot.Cache.get_cache
        Api.create_message(msg.channel_id, card)
      "!random" ->
        card = Scrybot.fetch_random
        Api.create_message(msg.channel_id, card)
      _ ->
        :ignore
    end
  end

  def handle_event _ do
    :noop
  end

end
