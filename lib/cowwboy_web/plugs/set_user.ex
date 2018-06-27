defmodule CowwboyWeb.Plugs.SetUser do
  import Plug.Conn

  alias Cowwboy.Accounts


  def init(_conn) do
  end

  def call(conn, _params) do
    if Map.has_key?(conn.assigns, :token) do
      case Phoenix.Token.verify(CowwboyWeb.Endpoint, "user salt", conn.assigns.token, max_age: 86400) do
        {:ok, user_id} ->
          conn = assign(conn, :user, Accounts.get_user!(user_id))
          conn
        _ -> conn
      end
      conn
    else
      conn
    end
  end
end
