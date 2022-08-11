defmodule Rh.Repo.Migrations.AddCompanyEmployeeTable do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      add :company_id, references(:companies, type: :binary_id)
    end
  end
end
