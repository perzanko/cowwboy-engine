defmodule CowwboyWeb.UserController do
  use CowwboyWeb, :controller

  alias Cowwboy.Accounts
  alias Cowwboy.Accounts.User

  action_fallback CowwboyWeb.FallbackController

  plug :check_owner when action in [:update, :delete]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, attrs) do
    with {:ok, %User{} = user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  defp check_owner(conn, _params) do
    %{params: %{"id" => user_id}} = conn

    case conn.assigns.user.id === String.to_integer(user_id) do
      true -> conn
      false -> conn
        |> put_status(:unauthorized)
        |> render(CowwboyWeb.ErrorView, :"401")
        |> halt()
    end
  end
end
