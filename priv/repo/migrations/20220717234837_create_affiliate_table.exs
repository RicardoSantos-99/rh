defmodule Rh.Repo.Migrations.CreateAffiliateTable do
  use Ecto.Migration

  def change do
    create table(:affiliates) do
      add :name, :string
      add :cnpj, :string
      add :company_id, references(:company, type: :binary_id)

      timestamps()
    end
  end
end
