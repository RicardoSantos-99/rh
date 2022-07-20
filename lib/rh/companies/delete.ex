defmodule Rh.Companies.Delete do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Company

  def call(id) do
    case Repo.get(Company, id) do
      nil -> {:error, Error.build_resource_not_found_error()}
      company -> Repo.delete(company)
    end
  end
end
