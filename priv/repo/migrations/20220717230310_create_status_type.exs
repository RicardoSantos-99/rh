defmodule Rh.Repo.Migrations.CreateStatusType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE status AS ENUM ('admitted', 'pending', 'canceled')"
    down_query = "DROP TYPE status"

    execute(up_query, down_query)
  end
end
