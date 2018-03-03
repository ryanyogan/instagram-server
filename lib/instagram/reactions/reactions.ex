defmodule Instagram.Reactions do
  import Ecto.Query, warn: false
  alias Instagram.Repo

  alias Instagram.Reactions.LikePhoto

  def like_photo(photo_id, user_id) do
    result = liked_photo_exists(photo_id, user_id)

    if result == nil do
      create_link_photo(%{photo_id: photo_id, user_id: user_id})
      {:ok, true}
    else
      delete_like_photo(result)
      {:ok, false}
    end
  end

  def viewer_liked_photo(photo_id, user_id) do
    result = liked_photo_exists(photo_id, user_id)

    if result == nil do
      {:ok, false}
    else
      {:ok, true}
    end
  end

  def create_link_photo(attrs \\ %{}) do
    %LikePhoto{}
    |> LikePhoto.changeset(attrs)
    |> Repo.insert()
  end

  def delete_like_photo(%LikePhoto{} = like_photo) do
    Repo.delete(like_photo)
  end

  defp liked_photo_exists(photo_id, user_id) do
    from(p in LikePhoto, where: p.photo_id == ^photo_id and p.user_id == ^user_id)
    |> Repo.one()
  end
end
