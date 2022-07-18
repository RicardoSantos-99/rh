defmodule Rh.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rh.{Affiliate, Term, Benefit, Document, Occupation}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:cnpj, :name, :corporate_name]

  schema "companies" do
    field :cnpj, :string
    field :name, :string
    field :corporate_name, :string

    has_many :affiliates, Affiliate
    has_many :terms, Term
    has_many :benefits, Benefit
    has_many :documents, Document
    has_many :occupations, Occupation

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cnpj, is: 14)
    |> unique_constraint([:cnpj])
    |> unique_constraint([:corporate_name])
  end
end
