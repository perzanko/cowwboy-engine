defmodule Cowwboy.PlayroomsTest do
  use Cowwboy.DataCase

  alias Cowwboy.Playrooms

  describe "playrooms" do
    alias Cowwboy.Playrooms.Playroom

    @valid_attrs %{name: "some name", private: true, pin: "123456", slots: [1]}
    @update_attrs %{name: "some updated name", private: false, pin: "", slots: [1, 2]}
    @invalid_attrs %{name: nil}

    def playroom_fixture(attrs \\ %{}) do
      {:ok, playroom} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Playrooms.create_playroom()

      playroom
    end

    test "list_playrooms/0 returns all playrooms" do
      playroom = playroom_fixture()
      assert is_list(Playrooms.list_playrooms()) == true and Enum.member?(Playrooms.list_playrooms(), playroom)
    end

    test "get_playroom!/1 returns the playroom with given id" do
      playroom = playroom_fixture()
      assert Playrooms.get_playroom!(playroom.id) == playroom
    end

    test "create_playroom/1 with valid data creates a playroom" do
      assert {:ok, %Playroom{} = playroom} = Playrooms.create_playroom(@valid_attrs)
      assert playroom.name == "some name"
    end

    test "create_playroom/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Playrooms.create_playroom(@invalid_attrs)
    end

    test "update_playroom/2 with valid data updates the playroom" do
      playroom = playroom_fixture()
      assert {:ok, playroom} = Playrooms.update_playroom(playroom, @update_attrs)
      assert %Playroom{} = playroom
      assert playroom.name == "some updated name"
    end

    test "update_playroom/2 with invalid data returns error changeset" do
      playroom = playroom_fixture()
      assert {:error, %Ecto.Changeset{}} = Playrooms.update_playroom(playroom, @invalid_attrs)
      assert playroom == Playrooms.get_playroom!(playroom.id)
    end

    test "delete_playroom/1 deletes the playroom" do
      playroom = playroom_fixture()
      assert {:ok, %Playroom{}} = Playrooms.delete_playroom(playroom)
      assert_raise Ecto.NoResultsError, fn -> Playrooms.get_playroom!(playroom.id) end
    end

    test "change_playroom/1 returns a playroom changeset" do
      playroom = playroom_fixture()
      assert %Ecto.Changeset{} = Playrooms.change_playroom(playroom)
    end
  end
end
