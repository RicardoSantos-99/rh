defmodule Rh.Repo.Migrations.ChangeTypeTokenForText do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      modify :token, :text
    end
  end
end
