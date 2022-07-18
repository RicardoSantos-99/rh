defmodule Rh.Repo.Migrations.CreateEmployeeTable do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :email, :string
      add :password_hash, :string
      add :name, :string
      add :cpf, :string
      add :employee, :employment_type
      add :affiliate_id, references(:affiliates, type: :binary_id)

      timestamps()
    end

    create unique_index(:employees, [:email])
    create unique_index(:employees, [:cpf])
  end
end
