defmodule Cowwboy.Repo.Migrations.ModifySlotsColumnType do
  use Ecto.Migration

  def change do
    alter table(:playrooms) do
      remove :slots
      add :slots, {:array, :integer}
    end
  end
end
