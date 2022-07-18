defmodule Rh.Repo.Migrations.CreateBenefitsTable do
  use Ecto.Migration

  def change do
    create table(:benefits) do
      add :name, :string
      add :description, :string
      add :company_id, references(:company, type: :binary_id)

      timestamps()
    end
  end
end
