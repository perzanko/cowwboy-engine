defmodule CowwboyWeb.Router do
  use CowwboyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CowwboyWeb.Plugs.IsAuthorized
    plug CowwboyWeb.Plugs.SetUser
  end

  scope "/", CowwboyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", CowwboyWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/weapons", WeaponController, only: [:index, :show]
    post "/login", AuthController, :login
    post "/register", UserController, :create
  end
end
