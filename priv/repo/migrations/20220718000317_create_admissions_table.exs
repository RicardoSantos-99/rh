defmodule Rh.Repo.Migrations.CreateAdmissionsTable do
  use Ecto.Migration

  def change do
    create table(:admissions) do
      add :salary, :decimal
      add :start_date, :date
      add :end_date, :date
      add :name, :string
      add :model, :model_type
      add :contract_type, :contract_type

      add :terms_id, references(:terms, type: :binary_id)
      add :benefits_id, references(:benefits, type: :binary_id)
      add :documents_id, references(:documents, type: :binary_id)
      add :affiliate_id, references(:affiliates, type: :binary_id)
      add :occupation_id, references(:occupations, type: :binary_id)

      timestamps()
    end
  end
end
