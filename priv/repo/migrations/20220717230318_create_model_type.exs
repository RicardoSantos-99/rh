defmodule Rh.Repo.Migrations.CreateModelType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE model_type AS ENUM ('HOMEWORK', 'HYBRID', 'FACE2FACE')"
    down_query = "DROP TYPE model_type"

    execute(up_query, down_query)
  end
end
