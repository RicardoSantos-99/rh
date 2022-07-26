defmodule Rh.Schema.Department do
  @moduledoc """
  Department schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.Schema.CostCenter

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :description, :code, :cost_center_id]

  schema "departments" do
    field :name, :string
    field :description, :string
    field :code, :string

    belongs_to :cost_center, CostCenter

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:code])
  end
end
