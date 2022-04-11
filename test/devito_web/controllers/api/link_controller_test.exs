defmodule DevitoWeb.API.LinkControllerTest do
  use DevitoWeb.ConnCase

  alias Devito.Test.Factory

  setup %{conn: conn} do
    System.put_env("AUTH_TOKEN", "abc123")

    test_token =
      :sha256
      |> :crypto.hash("abc123")
      |> Base.encode64()

    on_exit(fn -> System.delete_env("AUTH_TOKEN") end)

    %{conn: conn, test_token: test_token}
  end

  describe "GET /api" do
    setup %{conn: conn, test_token: test_token} do
      links = Factory.insert_list(5, :link)
      %{conn: conn, links: links, test_token: test_token}
    end

    test "gets all links", %{conn: conn, links: links, test_token: test_token} do
      conn = get(conn, "/api/", %{auth_token: test_token})
      assert %{"links" => returned_links} = json_response(conn, 200)
      assert length(returned_links) == length(links)
    end
  end

  describe "POST /api/link" do
    test "create a new link with a custom short_code", %{conn: conn, test_token: test_token} do
      conn =
        post(conn, "/api/link", %{
          "url" => "http://vaild.url",
          "short_code" => "v4l1d",
          "auth_token" => test_token
        })
      assert json_response(conn, 201)
    end

    test "create a new link with a random short_code", %{conn: conn, test_token: test_token} do
      conn =
        post(conn, "/api/link", %{
          "url" => "http://vaild.url",
          "auth_token" => test_token
        })
      assert json_response(conn, 201)
    end

    test "create a new link with a custom short_code that is already used", %{conn: conn, test_token: test_token} do
      link = Factory.insert(:link)
      conn =
        post(conn, "/api/link", %{
          "url" => "http://vaild.url",
          "short_code" => link.short_code,
          "auth_token" => test_token
        })
      assert json_response(conn, 400)
    end
  end

  describe "POST /api/import" do
    # Tests need to be implemented
  end

  describe "GET /api/:id" do
    setup %{conn: conn, test_token: test_token} do
      links = Factory.insert_list(5, :link)
      %{conn: conn, links: links, test_token: test_token}
    end

    test "gets an existing link", %{conn: conn, links: links, test_token: test_token} do
      random_link = Enum.random(links)
      conn = get(conn, "/api/#{random_link.short_code}", %{auth_token: test_token})
      assert returned_link = json_response(conn, 200)
      assert returned_link["short_code"] == random_link.short_code
      assert returned_link["url"] == random_link.url
    end

    test "tries to get a non-existent link", %{conn: conn, test_token: test_token} do
      conn = get(conn, "/api/n0tr34l", %{auth_token: test_token})
      assert json_response(conn, 404)
    end
  end
end
