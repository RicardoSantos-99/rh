defmodule Rh.Repo.Migrations.CreateOccupationTable do
  use Ecto.Migration

  def change do
    create table(:occupations) do
      add :name, :string
      add :description, :string
      add :code, :integer
      add :company_id, references(:companies, type: :binary_id)

      timestamps()
    end

    create unique_index(:occupations, [:name])
    create unique_index(:occupations, [:code])
  end
end
