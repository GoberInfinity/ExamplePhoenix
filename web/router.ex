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
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", Otherpool do
    pipe_through :api
    resources "/dummies", DummyController
  end

  # Other scopes may use custom stacks.
   scope "/api", Otherpool do
     pipe_through :api
     resources "/users", UserController, except: [:new, :edit]
   end
end
