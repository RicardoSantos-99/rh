defmodule Rh.Schema.Employee do
  @moduledoc """
  Employee schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Rh.Schema.{Affiliate, Company}
  alias Rh.Utils.Password

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @employees_type [:VALIDATOR, :RECRUIT, :MANAGER, :ADMIN]
  @required_params [:email, :password, :name, :cpf, :employee, :affiliate_id, :company_id]
  @params [:token] ++ @required_params

  schema "employees" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :cpf, :string
    field :token, :string

    field :employee, Enum, values: @employees_type

    belongs_to :affiliate, Affiliate
    belongs_to :company, Company

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    # TODO: Capitalize name and verify if cpf is valid and if email is valid
    struct
    |> cast(params, @params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> Password.put_password_hash()
  end
end
