defmodule Rh do
  @moduledoc """
  Rh is a API for working admissions.
  """

  alias Rh.{Affiliates, Companies, CostCenters, Departments, Employees, Occupations}

  defdelegate create_company(params), to: Companies.Create, as: :call
  defdelegate get_company(id), to: Companies.Get, as: :by_id
  defdelegate get_company_by_cnpj(cnpj), to: Companies.Get, as: :by_cnpj
  defdelegate delete_company(id), to: Companies.Delete, as: :call
  defdelegate list_companies, to: Companies.List, as: :call

  defdelegate create_occupation(params), to: Occupations.Create, as: :call
  defdelegate get_occupation(id), to: Occupations.Get, as: :by_id
  defdelegate delete_occupation(id), to: Occupations.Delete, as: :call
  defdelegate list_occupations, to: Occupations.List, as: :call

  defdelegate create_affiliate(params, current_user), to: Affiliates.Create, as: :call
  defdelegate get_affiliate(id, current_user), to: Affiliates.Get, as: :by_id
  defdelegate delete_affiliate(id, current_user), to: Affiliates.Delete, as: :call
  defdelegate list_affiliates(params), to: Affiliates.List, as: :call

  defdelegate create_cost_center(params), to: CostCenters.Create, as: :call
  defdelegate get_cost_center(id), to: CostCenters.Get, as: :by_id
  defdelegate get_cost_center_by_code(id), to: CostCenters.Get, as: :get_by_code
  defdelegate delete_cost_center(id), to: CostCenters.Delete, as: :call
  defdelegate list_cost_centers, to: CostCenters.List, as: :call

  defdelegate create_department(params), to: Departments.Create, as: :call
  defdelegate get_department(id), to: Departments.Get, as: :by_id
  defdelegate get_department_by_code(code), to: Departments.Get, as: :get_by_code
  defdelegate delete_department(id), to: Departments.Delete, as: :call
  defdelegate list_departments, to: Departments.List, as: :call

  defdelegate create_employee(params), to: Employees.Create, as: :call
  defdelegate get_employee(id), to: Employees.Get, as: :by_id
  defdelegate delete_employee(id), to: Employees.Delete, as: :call
  defdelegate list_employees, to: Employees.List, as: :call
end
