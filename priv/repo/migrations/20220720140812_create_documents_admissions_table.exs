defmodule Rh.Repo.Migrations.CreateDocumentsAdmissionsTable do
  use Ecto.Migration

  def change do
    create table(:documents_admissions) do
      add :admission_id, references(:admissions, type: :binary_id)
      add :document_id, references(:documents, type: :binary_id)
    end
  end
end
