defmodule Cowwboy.Weapons.Weapon do
  use Ecto.Schema
  import Ecto.Changeset


  schema "weapons" do
    field :damage, :integer
    field :model, :string
    field :name, :string
    field :reload, :integer

    timestamps()
  end

  @doc false
  def changeset(weapon, attrs) do
    weapon
    |> cast(attrs, [:name, :damage, :reload, :model])
    |> validate_required([:name, :damage, :reload, :model])
    |> validate_length(:name, min: 3, max: 30)
    |> unique_constraint(:name)
  end
end
