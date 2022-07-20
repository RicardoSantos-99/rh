defmodule Rh.Repo.Migrations.CreateEmployeesDepartmentsTable do
  use Ecto.Migration

  def change do
    create table(:employees_departments) do
      add :employee_id, references(:employees, type: :binary_id)
      add :department_id, references(:departments, type: :binary_id)

      timestamps()
    end
  end
end
