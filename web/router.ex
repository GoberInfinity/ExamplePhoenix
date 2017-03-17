defmodule Otherpool.Router do
  use Otherpool.Web, :router

 # pipeline :browser do
#    plug :accepts, ["html"]
#    plug :fetch_session
#    plug :fetch_flash
#    plug :protect_from_forgery
#    plug :put_secure_browser_headers
#  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Otherpool do
    pipe_through :api
    resources "/dummies", DummyController
  end

  # Other scopes may use custom stacks.
   scope "/api", Otherpool do
     pipe_through :api
     resources "/users", UserController, except: [:new, :edit]
     resources "/dealers", DealController, except: [:new, :edit]
     resources "/users", UserController do
      post "/dealers", DealController, :add_dealer
    end   
   end
end
