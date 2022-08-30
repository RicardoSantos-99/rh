defmodule Rh.Schema.Affiliate do
  @moduledoc """
  Affiliate schema.
  params = []
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.UUID
  alias Rh.Schema.{Admission, Company, CostCenter, Employee}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :cnpj, :company_id]

  @typedoc """
    Affiliates representation.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          cnpj: String.t(),
          company_id: UUID.t()
        }

  schema "affiliates" do
    field :name, :string
    field :cnpj, :string

    belongs_to :company, Company

    has_many :center_costs, CostCenter
    has_many :employees, Employee
    has_many :admissions, Admission

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cnpj, is: 14)
    |> unique_constraint([:name])
    |> unique_constraint([:cnpj])
  end
end
