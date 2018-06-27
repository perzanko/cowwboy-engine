defmodule CowwboyWeb.PageController do
  use CowwboyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
