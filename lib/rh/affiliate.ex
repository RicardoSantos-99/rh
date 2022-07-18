defmodule Rh.Affiliate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.{Company, Employee}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :cnpj, :company_id]

  schema "affiliates" do
    field :name, :string
    field :cnpj, :string

    belongs_to :company, Company

    has_many :employees, Employee

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
