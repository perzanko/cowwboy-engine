defmodule CowwboyWeb.AuthController do
  use CowwboyWeb, :controller

  alias Cowwboy.Accounts
  alias Cowwboy.Accounts.User
  alias Cowwboy.Auth.AuthUser

  action_fallback CowwboyWeb.FallbackController

  def login(conn, %{"nick" => nick, "password" => password}) do
    case AuthUser.authenticate_user(nick, password) do
      {:ok, user} ->
        conn
        |> fetch_session
        |> put_status(:ok)
        |> json(%{
          data: %{
            user: Map.drop(user, [:password]),
            token: Phoenix.Token.sign(CowwboyWeb.Endpoint, "user salt", user.id)
          }
        })
      {:error, _reason} -> render conn, CowwboyWeb.ErrorView, :"401"
    end
  end
end
