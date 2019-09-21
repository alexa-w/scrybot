defmodule Scrybot.Cache do
  require Cachex

  require Logger

  def get_cache key do
    Cachex.execute!(:scrybot_cache, fn(cache) ->
      cache_flow cache, key
    end)
  end

  def cache_flow cache, key do
    cache
    |> Cachex.get!(key)
    |> case do
      nil ->
        put_cache(cache, key)
      val ->
        val
    end
  end

  def put_cache cache, key do
    Logger.info "caching!"
    val = Scrybot.fetch_card key
    Cachex.put! cache, key, val
    cache_flow cache, key
  end
end
