defmodule InstagramWeb.Router do
  use InstagramWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug InstagramWeb.Context # IM -> OAuth2 Proto
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: InstagramWeb.Schema

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: InstagramWeb.Schema
    end
  end
end
