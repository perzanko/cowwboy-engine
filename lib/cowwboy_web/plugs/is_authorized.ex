defmodule CowwboyWeb.Plugs.IsAuthorized do
  import Plug.Conn
  import Phoenix.Controller

  # alias CowwboyWeb.Router.Helpers

  def init(_conn) do
  end

  def call(conn, _params) do
    # IO.puts "is_authorized conn in call"
    # IO.inspect conn
    if (conn.request_path == "/api/login" or conn.request_path == "/api/register" or Map.has_key?(conn.assigns, :no_auth)) do
      conn
    else
      conn
      |> check_auth
    end
  end

  defp check_auth(conn) do
    authorization = conn.req_headers
    |> Enum.map(fn (x) -> %{"#{elem(x, 0)}" => Tuple.delete_at(x, 0)} end)
    |> Enum.reduce(fn (x, acc) -> case x do
        %{"authorization" => _y} -> x
        _ -> acc
      end
    end)

    case authorization do
      %{"authorization" => authorizationString} -> conn
        |> validate_token(authorizationString)
      _ -> conn
        |> put_status(401)
        |> render(CowwboyWeb.ErrorView, :"401")
        |> halt()
    end
  end

  defp validate_token(conn, authorizationString) do
    if (is_tuple(authorizationString) && elem(authorizationString, 0) && String.split(elem(authorizationString, 0), " ")) do
      token = Enum.at(String.split(elem(authorizationString, 0), " "), 1)
      tokenVerification = Phoenix.Token.verify(CowwboyWeb.Endpoint, "user salt", token, max_age: 86400)
      case tokenVerification do
        {:ok, _} -> conn
          |> assign(:token, token)
        _ -> conn
          |> put_status(401)
          |> render(CowwboyWeb.ErrorView, :"401")
          |> halt()
      end
    else
      conn
        |> put_status(401)
        |> render(CowwboyWeb.ErrorView, :"401")
        |> halt()
    end
  end
end
