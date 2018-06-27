defmodule Cowwboy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nick, :string
      add :loses, :integer
      add :wins, :integer

      timestamps()
    end

  end
end
