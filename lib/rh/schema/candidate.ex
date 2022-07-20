defmodule Rh.Schema.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Rh.Schema.{Company, Admission}
  alias Rh.Utils.Password

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @gender [:FEMALE, :MALE]
  @status [:ADMITTED, :PENDING, :CANCELED]

  @required_params [
    :email,
    :password,
    :name,
    :status,
    :rg,
    :date_of_birth,
    :phone,
    :cellphone,
    :pis,
    :cep,
    :gender,
    :admission_id,
    :company_id
  ]

  schema "candidates" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :rg, :string
    field :date_of_birth, :date
    field :phone, :string
    field :cellphone, :string
    field :pis, :string
    field :cep, :string
    field :status, Enum, values: @status
    field :gender, Enum, values: @gender

    belongs_to :admission, Admission
    belongs_to :company, Company
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:email])
    |> unique_constraint([:pis])
    |> unique_constraint([:rg])
    |> Password.put_password_hash()
  end
end
