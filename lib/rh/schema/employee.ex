defmodule Rh.Schema.Employee do
  @moduledoc """
  Employee schema.
  """
  use Ecto.Schema
  use EnumType
  use TODO

  import Ecto.Changeset

  alias Ecto.{Enum, UUID}
  alias Rh.Schema.{Affiliate, Company}
  alias Rh.Utils.Password

  defenum EmployeeEnum do
    value VALIDATOR, :VALIDATOR
    value RECRUIT, :RECRUIT
    value MANAGER, :MANAGER
    value ADMIN, :ADMIN

    default(VALIDATOR)
  end

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @employees_type [:VALIDATOR, :RECRUIT, :MANAGER, :ADMIN]
  @required_params [:email, :password, :name, :cpf, :employees_type, :affiliate_id, :company_id]
  @params [:token] ++ @required_params

  @typedoc """
    Employees representation.
  """
  @type t :: %__MODULE__{
          email: String.t(),
          password: String.t(),
          name: String.t(),
          cpf: String.t(),
          employees_type: EmployeeEnum.t(),
          affiliate_id: UUID.t(),
          company_id: UUID.t(),
          token: String.t() | nil
        }

  schema "employees" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :cpf, :string
    field :token, :string

    field :employees_type, Enum, values: @employees_type

    belongs_to :affiliate, Affiliate
    belongs_to :company, Company

    timestamps()
  end

  @todo "0.0.1": "Capitalize name and verify if cpf is valid and if email is valid"
  def changeset(struct \\ %__MODULE__{}, params) do
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
