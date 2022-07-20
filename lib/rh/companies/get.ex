defmodule Rh.Companies.Get do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Company

  def by_id(id) do
    case Repo.get(Company, id) do
      nil -> {:error, Error.build(:not_found, "Company not found")}
      company -> {:ok, company}
    end
  end
end
