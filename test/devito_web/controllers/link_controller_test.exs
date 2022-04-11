defmodule DevitoWeb.LinkControllerTest do
  use DevitoWeb.ConnCase

  alias Devito.Test.Factory

  describe "GET /" do
    setup %{conn: conn} do
      link = Factory.insert(:link)
      %{conn: conn, link: link}
    end

    test "get a valid short code", %{conn: conn, link: link} do
      conn = get(conn, "/#{link.short_code}")
      assert html_response(conn, 301)
    end

    test "get an invalid short code", %{conn: conn} do
      conn = get(conn, "/1nv4l1dc0d3")
      assert html_response(conn, 404)
    end
  end
end
