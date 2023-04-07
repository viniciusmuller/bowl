defmodule Bowl.Store do
  require Logger

  @cache :bowl_cache

  def put(key, value, opts) do
    case Cachex.put(@cache, key, value, opts) do
      {:ok, true} ->
        :ok

      {:ok, false} ->
        Logger.debug("Failed to put key in cache: #{key}")
        :error
    end
  end

  def get(key) do
    case Cachex.get(@cache, key) do
      {:ok, nil} ->
        {:error, :not_found}

      {:ok, value} ->
        {:ok, value}

      {:error, reason} = err ->
        Logger.debug("Failed to get from cache: #{key} - #{reason}")
        err
    end
  end

  def delete(key) do
    case Cachex.del(@cache, key) do
      {:ok, true} ->
        :ok

      {:ok, false} ->
        Logger.debug("Failed to remove key from cache: #{key}")
        :error
    end
  end
end
