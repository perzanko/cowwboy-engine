defmodule Cowwboy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field :loses, :integer
    field :nick, :string
    field :password, :string
    field :wins, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nick, :password, :loses, :wins])
    |> validate_required([:nick, :password, :loses, :wins])
    |> validate_length(:nick, min: 3, max: 30)
    |> validate_length(:password, min: 6, max: 30)
    |> unique_constraint(:nick)
    |> put_password_hash()
  end

  @doc false
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
