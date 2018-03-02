defmodule InstagramWeb.Schema do
  use Absinthe.Schema

  alias InstagramWeb.Resolvers
  alias InstagramWeb.Schema.Middleware

  import_types __MODULE__.PostsTypes
  import_types __MODULE__.AccountsTypes

  query do
    @desc "Retreive a list of photos"
    field :photos, list_of(:photo) do
      middleware Middleware.Authorize
      resolve &Resolvers.Posts.photos/3
    end

    @desc "Retreive a single photo by ID"
    field :photo, :photo do
      arg :id, non_null(:id)
      resolve &Resolvers.Posts.photo/3
    end
  end

  mutation do
    @desc "Login via Facebook"
    field :login, :user_session do
      arg :token, :string
      arg :provider, type: :provider
      resolve &Resolvers.Accounts.login/3
    end
  end
end
