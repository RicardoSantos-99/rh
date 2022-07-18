defmodule Rh.Repo.Migrations.CreateOccupationTable do
  use Ecto.Migration

  def change do
    create table(:occupations) do
      add :name, :string
      add :description, :string
      add :code, :integer
      add :company_id, references(:company, type: :binary_id)

      timestamps()
    end
  end
end
