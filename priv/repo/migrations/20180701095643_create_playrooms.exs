defmodule Cowwboy.Repo.Migrations.CreatePlayrooms do
  use Ecto.Migration

  def change do
    create table(:playrooms) do
      add :name, :string
      add :private, :boolean
      add :pin, :string

      timestamps()
    end

  end
end
