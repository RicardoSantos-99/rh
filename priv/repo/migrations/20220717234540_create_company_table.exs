defmodule Rh.Repo.Migrations.CreateCompanyTable do
  use Ecto.Migration

  def change do
    create table(:company) do
      add :cnpj, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:company, [:cnpj])
  end
end
