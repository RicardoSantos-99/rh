defmodule Rh.Repo.Migrations.CreateEmploymentRelationshipType do
  use Ecto.Migration

  def change do
    up_query =
      "CREATE TYPE employment_relationship AS ENUM ('PJ', 'CLT', 'Contractor', 'Internship')"

    down_query = "DROP TYPE employment_relationship"

    execute(up_query, down_query)
  end
end
