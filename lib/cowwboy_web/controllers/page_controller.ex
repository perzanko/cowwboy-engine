defmodule CowwboyWeb.PageController do
  use CowwboyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def playrooms(conn, _params) do
    render conn, "playrooms.html"
  end
end
