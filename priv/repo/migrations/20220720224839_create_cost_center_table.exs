defmodule Rh.Repo.Migrations.CreateCostCenterTable do
  use Ecto.Migration

  def change do
    create table(:cost_centers) do
      add :name, :string
      add :description, :string
      add :code, :string

      add :affiliate_id, references(:affiliates, type: :binary_id)

      timestamps()
    end
  end
end
