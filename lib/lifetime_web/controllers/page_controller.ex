defmodule LifetimeWeb.PageController do
  use LifetimeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
