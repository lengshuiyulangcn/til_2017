defmodule Til.SessionController do
  use Til.Web, :controller
  alias Til.User
  alias Til.Session 

  def new(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> put_flash(:info, "Your already logged in")
      |> redirect(to: "/")
    else
      render conn, "new.html"
    end
  end

  def create(conn, %{"session" => session_params}) do
    case Session.login(session_params, Til.Repo) do
    {:ok, user} ->
      conn
      |> Guardian.Plug.sign_in(user)
      |> put_flash(:info, "Logged in")
      |> redirect(to: "/")
    :error ->
      conn
      |> put_flash(:info, "Wrong email or password")
      |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
