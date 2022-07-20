defmodule Rh.Repo.Migrations.CreateCenterCostTable do
  use Ecto.Migration

  def change do
    create table(:center_costs) do
      add :name, :string
      add :description, :string
      add :code, :string

      add :affiliate_id, references(:affiliates, type: :binary_id)

      timestamps()
    end

    create unique_index(:center_costs, [:code])
    create unique_index(:center_costs, [:name])
  end
end
