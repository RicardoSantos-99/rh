defmodule Rh.Schema.Occupation do
  @moduledoc """
  Occupation schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.UUID
  alias Rh.Schema.Company

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :description, :code, :company_id]

  @typedoc """
    Occupations representation.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          code: String.t(),
          company_id: UUID.t()
        }

  schema "occupations" do
    field :name, :string
    field :description, :string
    field :code, :integer

    belongs_to :company, Company

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
    |> unique_constraint([:code])
  end
end
