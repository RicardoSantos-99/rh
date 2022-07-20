defmodule Rh.Repo.Migrations.CreateAddPisColumnInCandidateTable do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :pis, :string
    end

    create unique_index(:candidates, [:rg])
    create unique_index(:candidates, [:pis])
  end
end
