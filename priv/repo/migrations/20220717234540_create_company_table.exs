defmodule Rh.Repo.Migrations.CreateCompanyTable do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :cnpj, :string
      add :name, :string
      add :corporate_name, :string

      timestamps()
    end

    create unique_index(:companies, [:cnpj])
    create unique_index(:companies, [:corporate_name])
  end
end
