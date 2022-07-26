defmodule Rh.Schema.Employee do
  @moduledoc """
  Employee schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Rh.Schema.Affiliate
  alias Rh.Utils.Password

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @employees_type [:VALIDATOR, :RECRUIT, :MANAGER, :ADMIN]
  @required_params [:email, :password, :name, :cpf, :employee, :affiliate_id]

  schema "employees" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :cpf, :string
    field :employee, Enum, values: @employees_type

    belongs_to :affiliate, Affiliate

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> Password.put_password_hash()
  end
end
