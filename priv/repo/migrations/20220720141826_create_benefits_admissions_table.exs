defmodule Rh.Repo.Migrations.CreateBenefitsAdmissionsTable do
  use Ecto.Migration

  def change do
    create table(:benefits_admissions) do
      add :admission_id, references(:admissions, type: :binary_id)
      add :benefit_id, references(:benefits, type: :binary_id)
    end
  end
end
