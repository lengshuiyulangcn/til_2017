defmodule Til.UsersController do
  use Til.Web, :controller
  alias Til.User
  alias Til.Repo
  alias Til.Session

  def new(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> put_flash(:info, "Your already logged in")
      |> redirect(to: "/")
    else
      changeset = User.new_changeset(%User{})
      render conn, changeset: changeset
    end
  end
  def edit(conn, _params) do unless conn.assigns.current_user do
      conn
      |> put_flash(:info, "You need login")
      |> redirect(to: "/")
    else
      changeset = User.new_changeset(%User{})
      render conn, changeset: changeset
    end
  end
  
  def create(conn, %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
       {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end

end
