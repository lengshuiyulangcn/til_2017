defmodule Til.Auth do
  import Plug.Conn

  def init(opts) do
    {}
  end

  def call(conn, {}) do
    user = Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, user)
  end
end
