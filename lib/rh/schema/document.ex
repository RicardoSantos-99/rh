defmodule Rh.Schema.Document do
  @moduledoc """
  A document schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.Schema.{Admission, Company}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :description]

  schema "documents" do
    field :name, :string
    field :description, :string

    belongs_to :company, Company
    many_to_many :admissions, Admission, join_through: "documents_admissions"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
  end
end
