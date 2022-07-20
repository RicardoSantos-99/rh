defmodule Rh.Repo.Migrations.CreateDepartmentTable do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :name, :string
      add :description, :string
      add :code, :string

      add :affiliate_id, references(:affiliates, type: :binary_id)

      timestamps()
    end

    create unique_index(:departments, [:code])
  end
end
