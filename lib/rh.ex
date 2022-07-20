defmodule Rh do
  alias Rh.Companies.Create, as: CreateCompany
  alias Rh.Companies.Get, as: GetCompany
  alias Rh.Companies.Delete, as: DeleteCompany
  alias Rh.Companies.List, as: ListCompanies

  defdelegate create_company(params), to: CreateCompany, as: :call
  defdelegate get_company(id), to: GetCompany, as: :by_id
  defdelegate delete_company(id), to: DeleteCompany, as: :call
  defdelegate list_companies, to: ListCompanies, as: :call
end
