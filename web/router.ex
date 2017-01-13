defmodule Til.Router do
  use Til.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do  
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Til.Auth 
  end

  scope "/", Til do
    pipe_through [:browser, :browser_auth] # Use the default browser stack
    resources "/users", UsersController, only: [:new, :create, :edit]
    resources "/posts", PostController
    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    resources "/tags", TagController, except: [:new, :edit] #ajax only
    delete "/logout", SessionController, :delete

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Til do
  #   pipe_through :api
  # end
end
