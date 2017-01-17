defmodule Blog.SessionController do
  use Blog.Web, :controller
  alias Blog.User
  import Comeonin.Bcrypt, only: [checkpw: 2]

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{username: "123"})
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    user =  Repo.get_by(User, username: username)
    if valid_password?(user, password) do
      conn
      |> sign_in(user)
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> sign_out
      |> put_flash(:error, "Invalid username/password combination!")
      |> render("new.html", changeset: User.changeset(%User{username: username}))
    end
  end

  defp sign_out(conn) do
    conn
    |> put_session(:current_user, nil)
  end

  defp sign_in(conn, user) do
    conn
    |> put_session(:current_user, %{id: user.id, username: user.username})
  end

  defp valid_password?(user, password) do
    user && checkpw(password, user.password_digest)
  end

end
