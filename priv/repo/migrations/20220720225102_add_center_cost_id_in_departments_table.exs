defmodule Rh.Repo.Migrations.AddCenterCostIdInDepartmentsTable do
  use Ecto.Migration

  def change do
    alter table(:departments) do
      add :cost_center_id, references(:cost_centers, type: :binary_id)
    end
  end
end
