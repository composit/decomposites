defmodule Decomposite.Session do
  alias Decomposite.User

  def signin(params, repo) do
    user = repo.get_by(User, name: params["name"])
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def current_user(conn) do
    id = current_user_id(conn)
    if id, do: Decomposite.Repo.get!(User, id)
  end

  def current_user_id(conn) do
    conn.assigns[:user_id]
  end

  def signed_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
