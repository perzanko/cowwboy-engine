defmodule Cowwboy.Repo.Migrations.CreateWeapons do
  use Ecto.Migration

  def change do
    create table(:weapons) do
      add :name, :string
      add :damage, :integer
      add :reload, :integer
      add :model, :string

      timestamps()
    end

  end
end
