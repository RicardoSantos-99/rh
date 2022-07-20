defmodule Rh.Repo.Migrations.AddCenterCostIdInDepartmentsTable do
  use Ecto.Migration

  def change do
    alter table(:departments) do
      add :center_cost_id, references(:center_costs, type: :binary_id)
    end
  end
end
