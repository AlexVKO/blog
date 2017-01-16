defmodule Blog.UserTest do
  use Blog.ModelCase

  alias Blog.User

  @invalid_attrs %{}
  @valid_attrs %{email: "some content",
                 password_confirmation: "some content",
                 password: "some content",
                 username: "some content"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
