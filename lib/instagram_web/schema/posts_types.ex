defmodule InstagramWeb.Schema.PostsTypes do
  use Absinthe.Schema.Notation
  alias InstagramWeb.Resolvers

  object :photo do
    field(:id, non_null(:id))
    field(:image_url, non_null(:string))
    field(:caption, :string)

    field(:viewer_liked, non_null(:boolean)) do
      resolve(&Resolvers.Reactions.viewer_liked_photo/3)
    end

    field(:inserted_at, non_null(:string))
    field(:updated_at, non_null(:string))
  end
end
