defmodule Rh.Repo.Migrations.CreateTermsTable do
  use Ecto.Migration

  def change do
    create table(:terms) do
      add :name, :string
      add :description, :string
      add :company_id, references(:companies, type: :binary_id)

      timestamps()
    end

    create unique_index(:terms, [:name])
  end
end
