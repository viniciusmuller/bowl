defmodule Bowl.Store do
  require Logger

  alias Bowl.Cache

  def put(key, value, opts \\ []) do
    Cache.put(key, value, opts)
  end

  def get(key) do
    case Cache.get(key) do
      nil ->
        {:error, :not_found}

      value ->
        {:ok, value}
    end
  end

  def delete(key) do
    Cache.delete(key)
  end
end
