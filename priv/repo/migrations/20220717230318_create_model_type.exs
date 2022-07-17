defmodule Rh.Repo.Migrations.CreateModelType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE model AS ENUM ('homework', 'hybrid', 'face2face')"
    down_query = "DROP TYPE model"

    execute(up_query, down_query)
  end
end
