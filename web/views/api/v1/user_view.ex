defmodule CciDemoPhoenix.Api.V1.UserView do
  use CciDemoPhoenix.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CciDemoPhoenix.Api.V1.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CciDemoPhoenix.Api.V1.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{name: user.name, email: user.email, bio: user.bio}
  end

  def render("error.json", _assigns) do
    %{error: "User not found."}
  end
end
