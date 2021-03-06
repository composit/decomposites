defmodule Decomposite.User do
  use Decomposite.Web, :model

  schema "users" do
    field :name, :string, unique: true
    field :crypted_password, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name password)
  @optional_fields ~w(crypted_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
    |> validate_length(:password, min: 5)
  end
end
