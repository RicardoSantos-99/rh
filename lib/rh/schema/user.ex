defmodule Rh.Schema.User do
  @moduledoc """
  Employee schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.Utils.Password

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :password, :name]
  @typedoc """
    Employees representation.
  """
  @type t :: %__MODULE__{
          email: String.t(),
          password: String.t(),
          name: String.t(),
          token: String.t() | nil
        }

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :token, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> Password.put_password_hash()
  end
end
