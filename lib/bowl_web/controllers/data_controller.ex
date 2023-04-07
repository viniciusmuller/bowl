defmodule BowlWeb.DataController do
  use BowlWeb, :controller

  alias Bowl.Store

  @ten_minutes 10 * 60 * 1000

  # TODO: metadata endpoint

  def show(conn, %{"id" => id}) do
    case Store.get(id) do
      {:error, :not_found} -> send_resp(conn, 404, "Key not found")
      {:ok, value} -> send_resp(conn, 200, value)
      {:error, _} -> send_resp(conn, 500, "Could not fetch key")
    end
  end

  def update(conn, %{"id" => id} = params) do
    ttl = parse_ttl(params["ttl"])

    with {:ok, body, conn} <- read_body(conn) do
      case Store.put(id, body, ttl: ttl) do
        :ok -> send_resp(conn, 201, "Key updated")
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

  defp parse_ttl(nil) do
    @ten_minutes
  end

  defp parse_ttl(ttl) do
    case Integer.parse(ttl) do
      {number, _} -> number
      _ -> @ten_minutes
    end
  end
end
