defmodule Bowl.Store do
  require Logger

  @cache :bowl_cache

  def list() do
    Cachex.keys(@cache)
  end

  def put(key, value) do
    case Cachex.put(@cache, key, value) do
      {:ok, true} ->
        :ok

      _ ->
        Logger.debug("Failed to put key in cache: #{key}")
        :error
    end
  end

  def get(key) do
    Cachex.get(@cache, key)
  end

  def delete(key) do
    case Cachex.del(@cache, key) do
      {:ok, true} ->
        :ok

      _ ->
        Logger.debug("Failed to remove key from cache: #{key}")
        :error
    end
  end
end
