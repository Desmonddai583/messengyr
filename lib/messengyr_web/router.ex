defmodule MessengyrWeb.Router do
  use MessengyrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", MessengyrWeb do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/", PageController, :index
    get "/signup", PageController, :signup
    get "/login", PageController, :login
    post "/signup", PageController, :create_user
    post "/login", PageController, :login_user
    get "/logout", PageController, :logout

    get "/messages", ChatController, :index
  end

  scope "/api", MessengyrWeb do
    pipe_through :api

    resources "/users", UserController, only: [:show]
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MessengyrWeb do
  #   pipe_through :api
  # end
end
