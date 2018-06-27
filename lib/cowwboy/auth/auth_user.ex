defmodule Cowwboy.Auth.AuthUser do
  @moduledoc """
  The AuthUser context.
  """

  import Ecto.Query, warn: false
  alias Comeonin.Bcrypt
  alias Cowwboy.Repo
  alias Cowwboy.Accounts.User

  def authenticate_user(nick, password) do
    Repo.get_by!(User, nick: nick)
    |> check_password(password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect username or password"}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end
end
