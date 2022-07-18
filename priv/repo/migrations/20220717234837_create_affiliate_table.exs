defmodule Rh.Repo.Migrations.CreateAffiliateTable do
  use Ecto.Migration

  def change do
    create table(:affiliates) do
      add :name, :string
      add :cnpj, :string
      add :company_id, references(:companies, type: :binary_id)

      timestamps()
    end

    create unique_index(:affiliates, [:name])
    create unique_index(:affiliates, [:cnpj])
  end
end
