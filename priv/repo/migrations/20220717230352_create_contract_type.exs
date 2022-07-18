defmodule Rh.Repo.Migrations.CreateContractType do
  use Ecto.Migration

  def change do
    up_query =
      "CREATE TYPE contract_type AS ENUM ('PJ', 'CLT', 'CONTRACTOR', 'INTERNSHIP', 'OTHER')"

    down_query = "DROP TYPE contract_type"

    execute(up_query, down_query)
  end
end
