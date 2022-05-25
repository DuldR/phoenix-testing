defmodule Auction do
  @moduledoc """
  Auction keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  alias Auction.{Item, Repo, User, Password}

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- Repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify
    end
  end


  def list_items do
    Repo.all(Item)
  end


  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()

  end

  def delete_item(%Auction.Item{} = item), do: Repo.delete(item)

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> Repo.update()

  end
  
  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  
  def new_item, do: Item.changeset(%Item{})

  def get_item(id) do
    Repo.get!(Item, id)
  end


  def get_item_by(attrs) do
    Repo.get_by(Item, attrs)
  end

  def get_user(id), do: Repo.get!(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> Repo.insert
  end
  
end
