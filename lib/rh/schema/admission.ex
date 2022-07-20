defmodule Rh.Schema.Admission do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Rh.Schema.{Company, Affiliate, Term, Benefit, Document, Occupation, Candidate}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @contract_model [:HOMEWORK, :HYBRID, :FACE2FACE]
  @contract_type [:PJ, :CLT, :CONTRACTOR, :INTERNSHIP, :OTHER]

  @required_params [
    :salary,
    :salary,
    :start_date,
    :end_date,
    :contract_type,
    :model,
    :company_id,
    :occupations_id,
    :employee_id
  ]

  schema "admissions" do
    field :salary, :decimal, redact: true
    field :start_date, :naive_datetime
    field :end_date, :naive_datetime
    field :contract_type, Enum, values: @contract_type
    field :contract_model, Enum, values: @contract_model

    belongs_to :affiliate, Affiliate
    belongs_to :company, Company

    many_to_many :documents, Document, join_through: "documents_admissions"
    many_to_many :benefits, Benefit, join_through: "benefits_admissions"
    many_to_many :terms, Term, join_through: "terms_admissions"

    has_one :occupation, Occupation

    has_many :candidates, Candidate
  end

  def changeset(struct \\ %__MODULE__{}, params, documents, benefits, terms) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:documents, documents)
    |> put_assoc(:benefits, benefits)
    |> put_assoc(:terms, terms)
  end
end
