defmodule Rh.Repo.Migrations.CreateDocumentsTable do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string
      add :description, :string
      add :company_id, references(:company, type: :binary_id)

      timestamps()
    end
  end
end
