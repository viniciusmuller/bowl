defmodule BowlWeb.DataController do
  use BowlWeb, :controller

  alias Bowl.Store

  def index(conn, params) do
    with {:ok, keys} <- Store.list() do
      json(conn, keys)
    end
  end

  def show(conn, %{"id" => id}) do
    case Store.get(id) do
      {:ok, nil} -> send_resp(conn, 404, "Key not found")
      {:ok, value} -> send_resp(conn, 200, value)
      {:error, _} -> send_resp(conn, 500, "Could not fetch key")
    end
  end

  def update(conn, %{"id" => id}) do
    with {:ok, body, conn} <- read_body(conn) do
      case Store.put(id, body) do
        :ok -> send_resp(conn, 201, "Key added")
        :error -> send_resp(conn, 500, "Could not set key")
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Store.delete(id) do
      :ok -> send_resp(conn, 204, "")
      :error -> send_resp(conn, 500, "Could not delete key")
    end
  end
end
