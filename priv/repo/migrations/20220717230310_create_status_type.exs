defmodule Rh.Repo.Migrations.CreateStatusType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE status_type AS ENUM ('ADMITTED', 'PENDING', 'CANCELED')"
    down_query = "DROP TYPE status_type"

    execute(up_query, down_query)
  end
end
