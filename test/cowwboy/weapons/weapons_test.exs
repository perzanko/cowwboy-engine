defmodule Cowwboy.WeaponsTest do
  use Cowwboy.DataCase

  alias Cowwboy.Weapons

  describe "weapons" do
    alias Cowwboy.Weapons.Weapon

    @valid_attrs %{damage: 42, model: "some model", name: "some name", reload: 42}
    @update_attrs %{damage: 43, model: "some updated model", name: "some updated name", reload: 43}
    @invalid_attrs %{damage: nil, model: nil, name: nil, reload: nil}

    def weapon_fixture(attrs \\ %{}) do
      {:ok, weapon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Weapons.create_weapon()

      weapon
    end

    test "list_weapons/0 returns all weapons" do
      weapon = weapon_fixture()
      assert Weapons.list_weapons() == [weapon]
    end

    test "get_weapon!/1 returns the weapon with given id" do
      weapon = weapon_fixture()
      assert Weapons.get_weapon!(weapon.id) == weapon
    end

    test "create_weapon/1 with valid data creates a weapon" do
      assert {:ok, %Weapon{} = weapon} = Weapons.create_weapon(@valid_attrs)
      assert weapon.damage == 42
      assert weapon.model == "some model"
      assert weapon.name == "some name"
      assert weapon.reload == 42
    end

    test "create_weapon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weapons.create_weapon(@invalid_attrs)
    end

    test "update_weapon/2 with valid data updates the weapon" do
      weapon = weapon_fixture()
      assert {:ok, weapon} = Weapons.update_weapon(weapon, @update_attrs)
      assert %Weapon{} = weapon
      assert weapon.damage == 43
      assert weapon.model == "some updated model"
      assert weapon.name == "some updated name"
      assert weapon.reload == 43
    end

    test "update_weapon/2 with invalid data returns error changeset" do
      weapon = weapon_fixture()
      assert {:error, %Ecto.Changeset{}} = Weapons.update_weapon(weapon, @invalid_attrs)
      assert weapon == Weapons.get_weapon!(weapon.id)
    end

    test "delete_weapon/1 deletes the weapon" do
      weapon = weapon_fixture()
      assert {:ok, %Weapon{}} = Weapons.delete_weapon(weapon)
      assert_raise Ecto.NoResultsError, fn -> Weapons.get_weapon!(weapon.id) end
    end

    test "change_weapon/1 returns a weapon changeset" do
      weapon = weapon_fixture()
      assert %Ecto.Changeset{} = Weapons.change_weapon(weapon)
    end
  end
end
