defmodule Rh.Repo.Migrations.CreateTermsAdmissionsTable do
  use Ecto.Migration

  def change do
    create table(:terms_admissions) do
      add :admission_id, references(:admissions, type: :binary_id)
      add :term_id, references(:terms, type: :binary_id)
    end
  end
end
