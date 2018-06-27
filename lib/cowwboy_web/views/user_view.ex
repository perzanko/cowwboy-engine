defmodule CowwboyWeb.UserView do
  use CowwboyWeb, :view
  alias CowwboyWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      nick: user.nick,
      loses: user.loses,
      wins: user.wins}
  end
end
