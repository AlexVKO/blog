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

  test "password_digest value gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    password_digest = Ecto.Changeset.get_change(changeset, :password_digest)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, password_digest)
  end

  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, %{email: "test@test.com", password: nil, password_confirmation: nil, username: "test"})
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
