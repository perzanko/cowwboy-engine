defmodule CowwboyWeb.WeaponView do
  use CowwboyWeb, :view
  alias CowwboyWeb.WeaponView

  def render("index.json", %{weapons: weapons}) do
    %{data: render_many(weapons, WeaponView, "weapon.json")}
  end

  def render("show.json", %{weapon: weapon}) do
    %{data: render_one(weapon, WeaponView, "weapon.json")}
  end

  def render("weapon.json", %{weapon: weapon}) do
    %{id: weapon.id,
      name: weapon.name,
      damage: weapon.damage,
      reload: weapon.reload,
      model: weapon.model}
  end
end
