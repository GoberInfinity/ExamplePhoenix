defmodule Otherpool.PersonChannel do
  use Otherpool.Web, :channel

  def join("person", payload, socket) do
      {:ok, "Joined persons:", socket}  
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end 
    
  def broadcast_change(person) do
  payload = %{
    "first_name" => person.first_name,
    "id" => person.id
  }
  Otherpool.Endpoint.broadcast("person", "change", payload)
  end

end
