defmodule Rh do
  @moduledoc """
  Rh is a API for working admissions.
  """

  alias Rh.{Affiliates, Companies, CostCenters, Departments, Employees, Occupations, Users}

  @doc """
  company is core module for working with companies.
  only SuperAdmin(USER) can access this module.
  """

  @spec create_company(Company.t(), User.t()) :: Company.t()
  defdelegate create_company(params, current_user), to: Companies.Create, as: :call

  defdelegate get_company(id, current_user), to: Companies.Get, as: :by_id
  defdelegate get_company_by_cnpj(cnpj, current_user), to: Companies.Get, as: :by_cnpj
  defdelegate delete_company(id, current_user), to: Companies.Delete, as: :call
  defdelegate list_companies(current_user), to: Companies.List, as: :call

  @doc """
  occupations belongs a company or are global.
  global occupations are available for all companies.
  only SuperAdmin can create global occupations.
  only Employees of the company with MANAGER permissions can create occupations.
  """
  defdelegate create_occupation(params), to: Occupations.Create, as: :call
  defdelegate get_occupation(id), to: Occupations.Get, as: :by_id
  defdelegate delete_occupation(id), to: Occupations.Delete, as: :call
  defdelegate list_occupations, to: Occupations.List, as: :call

  @doc """
  affiliate belongs to a company.
  only Employees of the company with ADMIN permission can create affiliates.
  """
  defdelegate create_affiliate(params, current_user), to: Affiliates.Create, as: :call
  defdelegate get_affiliate(id, current_user), to: Affiliates.Get, as: :by_id
  defdelegate delete_affiliate(id, current_user), to: Affiliates.Delete, as: :call
  defdelegate list_affiliates(company_id, current_user), to: Affiliates.List, as: :call

  defdelegate create_cost_center(params, current_user), to: CostCenters.Create, as: :call
  defdelegate get_cost_center(id), to: CostCenters.Get, as: :by_id
  defdelegate get_cost_center_by_code(id), to: CostCenters.Get, as: :get_by_code
  defdelegate delete_cost_center(id), to: CostCenters.Delete, as: :call
  defdelegate list_cost_centers, to: CostCenters.List, as: :call

  defdelegate create_department(params), to: Departments.Create, as: :call
  defdelegate get_department(id), to: Departments.Get, as: :by_id
  defdelegate get_department_by_code(code), to: Departments.Get, as: :get_by_code
  defdelegate delete_department(id), to: Departments.Delete, as: :call
  defdelegate list_departments, to: Departments.List, as: :call

  @doc """
  Employee is affiliate's worker.
  He should be a member of the one affiliate.
  """
  defdelegate login(params), to: Employees.Login, as: :call
  defdelegate logout(current_user), to: Employees.Update, as: :revoke_token
  defdelegate create_employee(params, current_user), to: Employees.Create, as: :call
  defdelegate get_employee(id, current_user), to: Employees.Get, as: :by_id
  defdelegate get_by_email(email, current_user), to: Employees.Get, as: :by_email
  defdelegate delete_employee(id, current_user), to: Employees.Delete, as: :call
  defdelegate list_employees(current_user), to: Employees.List, as: :call

  @doc """
  user is a user of the system.
  an user has SuperAdmin permissions
  """
  defdelegate user_login(params), to: Users.Create, as: :login
  defdelegate user_create_employee(params, current_user), to: Users.Create, as: :employee
  defdelegate user_create_affiliate(params, current_user), to: Users.Create, as: :affiliate
  defdelegate user_create_company(params, current_user), to: Users.Create, as: :company
  defdelegate create_occupation(params, current_user), to: Users.Create, as: :occupation
  defdelegate user_list_companies(current_user), to: Users.List, as: :companies
  defdelegate user_list_affiliates(company_id, current_user), to: Users.List, as: :affiliates

  defdelegate user_list_employees_by_affiliate(affiliate_id, current_user),
    to: Users.List,
    as: :employees_by_affiliate

  defdelegate user_list_employees_by_company(company_id, current_user),
    to: Users.List,
    as: :employees_by_company

  # defdelegate logout(current_user), to: Users.Update, as: :revoke_token
end
