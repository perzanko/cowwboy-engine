defmodule CowwboyWeb.PlayroomsChannel do
  use CowwboyWeb, :channel

  alias Cowwboy.Playrooms
  alias Cowwboy.Playrooms.Playroom


  def join("playrooms", payload, socket) do
    if authorized?(payload) do
      {:ok, %{playrooms: Playrooms.list_playrooms}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("playrooms:create", payload, socket) do

    case Playrooms.create_playroom(payload) do
      {:ok, %Playroom{} = playroom} ->
        {:reply, {:ok, %{playroom: playroom}}, socket}
      {:error, _reason} ->
        {:reply, :error, socket}
    end
  end

  def handle_in("playrooms:join", %{"playroom_id" => playroom_id, "user_id" => user_id}, socket) do
    playroom = Playrooms.get_playroom!(playroom_id)
    if (length(playroom.slots) < 2 == true) do
      case Playrooms.update_playroom(playroom, %{slots: playroom.slots ++ [user_id]}) do
        {:ok, joined_playroom} ->
          broadcast socket, "playrooms:change", %{playrooms: Playrooms.list_playrooms}
          {:reply, {:ok, joined_playroom}, socket}
        _ -> {:reply, :error, socket}
      end
    else
      {:reply, :error, socket}
    end
  end

  def handle_in("playrooms:ping", _payload, socket) do
    {:reply, {:ok, %{pong: 1}}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (playrooms:lobby).
  def handle_in("playrooms:shout", payload, socket) do
    broadcast socket, "playrooms:shout", payload
    {:noreply, socket}
  end

  def handle_in("playrooms:test_commands", _payload, socket) do
    commands = [
      %{command: "playrooms:ping", payload: %{}},
      %{command: "playrooms:shout", payload: %{}},
      %{command: "playrooms:create", payload: %{name: "Pokój publiczny", private: false, slots: [1]}},
      %{command: "playrooms:create", payload: %{name: "Pokój prywatny", private: true, pin: "123456", slots: [1]}},
      %{command: "playrooms:join", payload: %{playroom_id: 35, user_id: 2}},
    ]
    {:reply, {:ok, %{commands: commands}}, socket}
  end

  def handle_in("playrooms:test_listeners", _payload, socket) do
    listeners = [
      "playrooms:shout",
      "playrooms:change",
    ]
    {:reply, {:ok, %{listeners: listeners}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
