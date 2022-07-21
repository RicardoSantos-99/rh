defmodule Rh do
  alias Rh.Companies.Create, as: CreateCompany
  alias Rh.Companies.Get, as: GetCompany
  alias Rh.Companies.Delete, as: DeleteCompany
  alias Rh.Companies.List, as: ListCompanies

  alias Rh.Occupations.Create, as: CreateOccupation
  alias Rh.Occupations.Get, as: GetOccupation
  alias Rh.Occupations.Delete, as: DeleteOccupation
  alias Rh.Occupations.List, as: ListOccupations

  alias Rh.Affiliates.Create, as: CreateAffiliate
  alias Rh.Affiliates.Get, as: GetAffiliate
  alias Rh.Affiliates.Delete, as: DeleteAffiliate
  alias Rh.Affiliates.List, as: ListAffiliates

  defdelegate create_company(params), to: CreateCompany, as: :call
  defdelegate get_company(id), to: GetCompany, as: :by_id
  defdelegate get_company_by_cnpj(cnpj), to: GetCompany, as: :by_cnpj
  defdelegate delete_company(id), to: DeleteCompany, as: :call
  defdelegate list_companies, to: ListCompanies, as: :call

  defdelegate create_occupation(params), to: CreateOccupation, as: :call
  defdelegate get_occupation(id), to: GetOccupation, as: :by_id
  defdelegate delete_occupation(id), to: DeleteOccupation, as: :call
  defdelegate list_occupations, to: ListOccupations, as: :call

  defdelegate create_affiliate(params), to: CreateAffiliate, as: :call
  defdelegate get_affiliate(id), to: GetAffiliate, as: :by_id
  defdelegate delete_affiliate(id), to: DeleteAffiliate, as: :call
  defdelegate list_affiliates, to: ListAffiliates, as: :call
end
