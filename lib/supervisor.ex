defmodule Scrybot.Supervisor do
  def start_link do

    import Supervisor.Spec

    children = [
      worker(Scrybot.Consumer, [], restart: :permanent),
      worker(Cachex, [:scrybot_cache, []], restart: :permanent)
    ]

    Supervisor.start_link children, strategy: :one_for_one
  end
end
