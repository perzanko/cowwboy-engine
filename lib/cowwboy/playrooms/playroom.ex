defmodule Cowwboy.Playrooms.Playroom do
  use Ecto.Schema
  import Ecto.Changeset


  schema "playrooms" do
    field :name, :string
    field :private, :boolean
    field :pin, :string
    field :slots, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(playroom, attrs) do
    playroom
    |> cast(attrs, [:name, :private, :pin, :slots])
    |> validate_required([:name, :private, :slots])
  end
end
