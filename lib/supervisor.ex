defmodule Scrybot.Supervisor do
  def start_link do

    children = [Scrybot.Consumer]

    Supervisor.start_link children, strategy: :one_for_one
  end
end
