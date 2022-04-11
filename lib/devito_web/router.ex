defmodule DevitoWeb.Router do
  use DevitoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DevitoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DevitoWeb.Plugs.APIAuth
  end

  scope "/api/", DevitoWeb do
    pipe_through :api
    get "/", API.LinkController, :index
    post "/link", API.LinkController, :create
    post "/import", API.LinkController, :import
    get "/:id", API.LinkController, :show
  end

  scope "/", DevitoWeb do
    pipe_through :browser
    get "/:short_code", LinkController, :show
  end
end
