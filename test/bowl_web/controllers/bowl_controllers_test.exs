defmodule BowlWeb.DataControllerTest do
  use BowlWeb.ConnCase, async: false

  test "stores and retrieves data in the cache", %{conn: conn} do
    {key, value} = {"my-key", "my-value"}

    conn =
      conn
      |> put_req_header("content-type", "application/octet-stream")
      |> put(~p"/api/data/#{key}", value)

    assert response(conn, 201) =~ "Key updated"

    conn = get(conn, ~p"/api/data/#{key}")
    assert response(conn, 200) =~ value
  end

  test "evicts data from the cache", %{conn: conn} do
    {key, value} = {"my-key", "my-value"}

    conn =
      conn
      |> put_req_header("content-type", "application/octet-stream")
      |> put(~p"/api/data/#{key}", value)

    assert response(conn, 201) =~ "Key updated"

    conn = delete(conn, ~p"/api/data/#{key}")

    assert response(conn, 204) == ""
  end

  test "correctly sets and evict data with TTL", %{conn: conn} do
    {key, value} = {"my-key", "my-value"}

    conn =
      conn
      |> put_req_header("content-type", "application/octet-stream")
      # 100 ms TTL
      |> put(~p"/api/data/#{key}?ttl=100", value)

    assert response(conn, 201) =~ "Key updated"

    conn = get(conn, ~p"/api/data/#{key}")
    assert response(conn, 200) =~ value

    # Sleep for 125ms just to be sure
    :timer.sleep(125)

    conn = get(conn, ~p"/api/data/#{key}")
    assert response(conn, 404)
  end
end
