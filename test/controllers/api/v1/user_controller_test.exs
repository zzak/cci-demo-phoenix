defmodule CciDemoPhoenix.Api.V1.UserControllerTest do
  use CciDemoPhoenix.ConnCase

  alias CciDemoPhoenix.User
  @valid_attrs %{bio: "my life", email: "pat@example.com", name: "Pat Example", number_of_pets: 4}
  @invalid_attrs %{}

  # JSON API tests

  test "index/2 responds with all Users" do
    users = [ User.changeset(%User{}, %{name: "John", email: "john@example.com", bio: "zomg"}),
              User.changeset(%User{}, %{name: "Jane", email: "jane@example.com", bio: "zomg"}) ]

    Enum.each(users, &Repo.insert!(&1))

    response = build_conn
    |> get(api_v1_user_path(build_conn, :index))
    |> json_response(200)

    expected = %{
      "data" => [
        %{ "name" => "John", "email" => "john@example.com", "bio" => "zomg"},
        %{ "name" => "Jane", "email" => "jane@example.com", "bio" => "zomg"}
      ]
    }

    assert response == expected
  end

  test "Responds with newly created user if user is found" do
    user = User.changeset(%User{}, %{name: "John", email: "john@example.com", bio: "zomg"})
    |> Repo.insert!

    response = build_conn
    |> get(api_v1_user_path(build_conn, :show, user.id))
    |> json_response(200)

    expected = %{ "data" => %{ "name" => "John", "email" => "john@example.com", "bio" => "zomg" } }

    assert response == expected
  end

  test "Responds with a message indicating user not found" do
    response = build_conn
    |> get(api_v1_user_path(build_conn, :show, 300))
    |> json_response(404)

    expected = %{ "error" => "User not found." }

    assert response == expected
  end
end
