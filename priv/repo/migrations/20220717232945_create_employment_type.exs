defmodule Rh.Repo.Migrations.CreateEmploymentType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE employment_type AS ENUM ('VALIDATOR', 'RECRUIT', 'MANAGER', 'ADMIN')"

    down_query = "DROP TYPE employment_type"

    execute(up_query, down_query)
  end
end
