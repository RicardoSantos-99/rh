defmodule Rh.Repo.Migrations.CreateCandidateTable do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :email, :string
      add :password_hash, :string
      add :name, :string
      add :cpf, :string
      add :rg, :string
      add :phone, :string
      add :cellphone, :string
      add :birthday, :date
      add :cep, :string
      add :gender_type, :gender_type
      add :status, :status_type

      add :admission_id, references(:admissions, type: :binary_id)

      timestamps()
    end

    create unique_index(:candidates, [:cpf])
    create unique_index(:candidates, [:email])
  end
end
