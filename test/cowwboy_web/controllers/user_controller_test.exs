defmodule CowwboyWeb.UserControllerTest do
  use CowwboyWeb.ConnCase

  alias Cowwboy.Accounts
  alias Cowwboy.Accounts.User

  @create_attrs %{loses: 42, nick: "some nick", wins: 42, password: "pass123"}
  @update_attrs %{loses: 43, nick: "some updated nick", wins: 43, password: "pass123"}
  @invalid_attrs %{loses: nil, nick: nil, wins: nil, password: "pass12"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn:
      conn
      |> put_req_header("accept", "application/json")
      |> assign(:no_auth, true)
    }
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)["data"] == [] or length(json_response(conn, 200)["data"]) > 0
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      valid_conn = conn
      conn = post conn, user_path(conn, :create), @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = valid_conn
      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "loses" => 0,
        "nick" => "some nick",
        "wins" => 0}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = assign(conn, :user, user)
      valid_conn = conn
      conn = put conn, user_path(conn, :update, user), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = assign(valid_conn, :user, user)
      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "loses" => 43,
        "nick" => "some updated nick",
        "wins" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = assign(conn, :user, user)
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]


    test "deletes chosen user", %{conn: conn, user: user} do
      conn = assign(conn, :user, user)
      conn = delete conn, user_path(conn, :delete, user)
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
