defmodule AuctionWeb.ItemChannel do
  use Phoenix.Channel

  def join("item:" <> _item_id, _params, socket) do
    IO.inspect("Joined")
    {:ok, socket}
  end

  def handle_in("new_bid", params, socket) do
    
    IO.inspect("hit")

    PhoenixChannel.broadcast!(socket, "new_bid", params)
    {:noreply, socket}
  end


end

