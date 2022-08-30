defmodule Rh.Repositories.CompanyRepository do
  import Ecto.Query

  alias Rh.Repo
  alias Rh.Schema.Company

  def select_company_id(id) do
    Repo.one(from a in Company, where: a.id == ^id, select: a.id)
  end

  def companies do
    Repo.all(Company)
  end
end
