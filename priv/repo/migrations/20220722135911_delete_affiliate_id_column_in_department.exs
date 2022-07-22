defmodule Rh.Repo.Migrations.DeleteAffiliateIdColumnInDepartment do
  use Ecto.Migration

  def change do
    alter table(:departments) do
      remove :affiliate_id
    end
  end
end
