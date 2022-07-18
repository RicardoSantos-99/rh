defmodule Rh.Repo.Migrations.CreateGenderType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE gender_type AS ENUM ('FEMALE', 'MALE')"
    down_query = "DROP TYPE gender_type"

    execute(up_query, down_query)
  end
end
