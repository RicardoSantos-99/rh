defmodule Rh do
  @moduledoc """
  Rh is a API for working admissions.

  **User**
  - User is a user of the system.
  - an user has SuperAdmin permissions company is core module for working with companies
  - Only SuperAdmin(USER) can access this module.

  **Occupation**
  - Occupations belongs a company or are global.
  - Global occupations are available for all companies.
  - Only SuperAdmin can create global occupations.
  - Only Employees of the company with MANAGER permissions can create occupations.


  **Affiliate**
  - Affiliate belongs to a company.
  - Only Employees of the company with ADMIN permission can create affiliates.

  **Employee**
  - Employee is affiliate's worker.
  - He should be a member of the one affiliate.
  """

  alias Ecto.UUID
  alias Rh.{Affiliates, Companies, CostCenters, Departments, Employees, Occupations, Users}
  alias Rh.Schema.{Affiliate, Company, Employee, Occupation, User}

  @spec create_company(Company.t(), User.t()) :: Company.t()
  defdelegate create_company(params, current_user), to: Companies.Create, as: :call

  @spec get_company(UUID.t(), User.t()) :: Company.t()
  defdelegate get_company(id, current_user), to: Companies.Get, as: :by_id

  @spec get_company_by_cnpj(String.t(), User.t()) :: Company.t()
  defdelegate get_company_by_cnpj(cnpj, current_user), to: Companies.Get, as: :by_cnpj

  @spec delete_company(UUID.t(), User.t()) :: Company.t()
  defdelegate delete_company(id, current_user), to: Companies.Delete, as: :call

  @spec list_companies(User.t()) :: [Company.t()]
  defdelegate list_companies(current_user), to: Companies.List, as: :call

  @spec create_occupation(Occupation.t()) :: Occupation.t()
  defdelegate create_occupation(params), to: Occupations.Create, as: :call

  @spec get_occupation(UUID.t()) :: Occupation.t()
  defdelegate get_occupation(id), to: Occupations.Get, as: :by_id

  @spec delete_occupation(UUID.t()) :: Occupation.t()
  defdelegate delete_occupation(id), to: Occupations.Delete, as: :call

  @spec list_occupations() :: [Occupation.t()]
  defdelegate list_occupations, to: Occupations.List, as: :call

  @spec create_affiliate(Affiliate.t(), Employee.t()) :: Affiliate.t()
  defdelegate create_affiliate(params, current_user), to: Affiliates.Create, as: :call

  @spec get_affiliate(UUID.t(), Employee.t()) :: Affiliate.t()
  defdelegate get_affiliate(id, current_user), to: Affiliates.Get, as: :by_id

  @spec delete_affiliate(UUID.t(), Employee.t()) :: Affiliate.t()
  defdelegate delete_affiliate(id, current_user), to: Affiliates.Delete, as: :call

  @spec list_affiliates(UUID.t(), Employee.t()) :: [Affiliate.t()]
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

  defdelegate login(params), to: Employees.Login, as: :call
  defdelegate logout(current_user), to: Employees.Update, as: :revoke_token
  defdelegate create_employee(params, current_user), to: Employees.Create, as: :call
  defdelegate get_employee(id, current_user), to: Employees.Get, as: :by_id
  defdelegate get_by_email(email, current_user), to: Employees.Get, as: :by_email
  defdelegate delete_employee(id, current_user), to: Employees.Delete, as: :call
  defdelegate list_employees(current_user), to: Employees.List, as: :call

  defdelegate user_login(params), to: Users.Create, as: :login

  @spec user_create_employee(Employee.t(), User.t()) :: Employee.t()
  defdelegate user_create_employee(params, current_user), to: Users.Create, as: :employee

  @spec user_create_affiliate(Affiliate.t(), User.t()) :: Affiliate.t()
  defdelegate user_create_affiliate(params, current_user), to: Users.Create, as: :affiliate

  @spec user_create_company(Company.t(), User.t()) :: Company.t()
  defdelegate user_create_company(params, current_user), to: Users.Create, as: :company

  @spec user_create_occupation(Occupation.t(), User.t()) :: Occupation.t()
  defdelegate user_create_occupation(params, current_user), to: Users.Create, as: :occupation

  @spec user_list_companies(User.t()) :: [Company.t()]
  defdelegate user_list_companies(current_user), to: Users.List, as: :companies

  @spec user_list_affiliates(UUID.t(), User.t()) :: [Affiliate.t()]
  defdelegate user_list_affiliates(company_id, current_user), to: Users.List, as: :affiliates

  @spec user_list_employees_by_affiliate(UUID.t(), User.t()) :: [Employee.t()]
  defdelegate user_list_employees_by_affiliate(affiliate_id, current_user),
    to: Users.List,
    as: :employees_by_affiliate

  @spec user_list_employees_by_company(UUID.t(), User.t()) :: [Employee.t()]
  defdelegate user_list_employees_by_company(company_id, current_user),
    to: Users.List,
    as: :employees_by_company

  # defdelegate logout(current_user), to: Users.Update, as: :revoke_token
end
