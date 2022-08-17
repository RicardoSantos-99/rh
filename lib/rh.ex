defmodule Rh do
  @moduledoc """
  Rh is a API for working admissions.
  """

  alias Rh.{Affiliates, Companies, CostCenters, Departments, Employees, Occupations, Users}

  defdelegate create_company(params, current_user), to: Companies.Create, as: :call
  defdelegate get_company(id, current_user), to: Companies.Get, as: :by_id
  defdelegate get_company_by_cnpj(cnpj, current_user), to: Companies.Get, as: :by_cnpj
  defdelegate delete_company(id, current_user), to: Companies.Delete, as: :call
  defdelegate list_companies(current_user), to: Companies.List, as: :call

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

  defdelegate login(params), to: Employees.Login, as: :call
  defdelegate logout(current_user), to: Employees.Update, as: :revoke_token
  defdelegate create_employee(params, current_user), to: Employees.Create, as: :call
  defdelegate get_employee(id, current_user), to: Employees.Get, as: :by_id
  defdelegate get_by_email(email, current_user), to: Employees.Get, as: :by_email
  defdelegate delete_employee(id, current_user), to: Employees.Delete, as: :call
  defdelegate list_employees(current_user), to: Employees.List, as: :call

  defdelegate user_login(params), to: Users.Create, as: :login
  defdelegate user_create_employee(params, current_user), to: Users.Create, as: :create_employee
  defdelegate user_create_affiliate(params, current_user), to: Users.Create, as: :create_affiliate

  # defdelegate logout(current_user), to: Users.Update, as: :revoke_token
end
