defmodule CowwboyWeb.WeaponControllerTest do
  use CowwboyWeb.ConnCase

  alias Cowwboy.Weapons
  alias Cowwboy.Weapons.Weapon

  @create_attrs %{damage: 42, model: "some model", name: "some name", reload: 42}

  def fixture(:weapon) do
    {:ok, weapon} = Weapons.create_weapon(@create_attrs)
    weapon
  end

  setup %{conn: conn} do
    {:ok, conn: conn
      |> put_req_header("accept", "application/json")
      |> assign(:no_auth, true)
    }
  end

  describe "index" do
    test "lists all weapons", %{conn: conn} do
      conn = get conn, weapon_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
end
