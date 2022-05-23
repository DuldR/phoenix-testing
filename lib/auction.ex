defmodule Auction do
  @moduledoc """
  Auction keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  alias Auction.Item

  @repo Auction.Repo

  def list_items do
    @repo.all(Item)
  end


  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()

  end

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()

  end
  
  def new_item, do: Item.changeset(%Item{})

  def get_item(id) do
    @repo.get!(Item, id)
  end


  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)

  end

end
