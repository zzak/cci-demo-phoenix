defmodule CciDemoPhoenix.Router do
  use CciDemoPhoenix.Web, :router

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

  pipeline :review_checks do
    # plug :ensure_authenticated_user
    # plug :ensure_user_owns_review
  end

  scope "/", CciDemoPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController do
      resources "/posts", PostController
    end
    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]
  end

  scope "/admin", CciDemoPhoenix.Admin, as: :admin do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  scope "/api", CciDemoPhoenix.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/images", ImageController
      resources "/users", UserController
    end
  end

  scope "/reviews", CciDemoPhoenix do
    pipe_through [:browser, :review_checks]

    resources "/", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CciDemoPhoenix do
  #   pipe_through :api
  # end
end
