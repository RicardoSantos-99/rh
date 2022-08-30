defmodule Rh.Schema.Company do
  @moduledoc """
  Company schema.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Rh.Schema.{Admission, Affiliate, Benefit, Candidate, Document, Employee, Occupation, Term}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:cnpj, :name, :corporate_name]

  @type t :: %__MODULE__{
          cnpj: String.t(),
          name: String.t(),
          corporate_name: String.t()
        }

  schema "companies" do
    field :cnpj, :string
    field :name, :string
    field :corporate_name, :string

    has_many :affiliates, Affiliate
    has_many :admissions, Admission
    has_many :employees, Employee

    has_many :terms, Term
    has_many :benefits, Benefit
    has_many :documents, Document
    has_many :occupations, Occupation

    has_many :candidates, Candidate

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cnpj, is: 14)
    |> unique_constraint([:cnpj])
    |> unique_constraint([:corporate_name])
    |> cast_assoc(:affiliates)
  end
end
