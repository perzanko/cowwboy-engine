defmodule Cowwboy.Repo.Migrations.Add_assoc_with_slots_in_playroom do
  use Ecto.Migration

  def change do
    alter table(:playrooms) do
      add :slots, {:array, :string}
    end
  end
end
