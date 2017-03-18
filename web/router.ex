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

  # Other scopes may use custom stacks.
   scope "/api", Otherpool do
     pipe_through :api
     resources "/users", UserController, except: [:new, :edit]
     resources "/dealers", DealController, except: [:new, :edit]
     resources "/sales", SaleController, except: [:new, :edit]  
     resources "/userps", UserpController, except: [:new, :edit]
     resources "/person_companies", Person_CompanyController, except: [:new, :edit]
     resources "/sale_types", Sale_TypeController, except: [:new, :edit]
     resources "/user_types", User_TypeController, except: [:new, :edit]
     resources "/persons", PersonController, except: [:new, :edit]   
     resources "/person_phones", Person_PhoneController, except: [:new, :edit]  
     resources "/users", UserController do
      post "/dealers", DealController, :add_dealer
      
    end   
   end
end
