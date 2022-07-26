defmodule Rh.Schema.CostCenter do
  @moduledoc """
  A cost center schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.Schema.{Affiliate, Department}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :description, :code, :affiliate_id]

  schema "cost_centers" do
    field :name, :string
    field :description, :string
    field :code, :string

    belongs_to :affiliate, Affiliate

    has_many :departments, Department

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:code])
  end
end
