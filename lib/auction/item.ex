defmodule Auction.Item do

  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    has_many :bids, Auction.Bid
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
    |> Ecto.Changeset.cast(params, [:title, :description, :ends_at])
    |> Ecto.Changeset.validate_required(:title)
    |> validate_length(:description, max: 300)
    |> validate_length(:title, min: 3)
    |> validate_change(:ends_at, &validate/2)
  end

  defp validate(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt -> [ends_at: "can't be in the past"]
      _ -> []
    end
  end
end




