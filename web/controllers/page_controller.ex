defmodule CciDemoPhoenix.PageController do
  use CciDemoPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
