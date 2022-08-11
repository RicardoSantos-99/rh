defmodule Rh.Repo.Migrations.AddTokenEmployeeTable do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      add :token, :string
    end
  end
end
