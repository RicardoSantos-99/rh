defmodule Rh.Users.List do
  alias Rh.Schema.User
  alias Rh.Repositories.{AffiliateRepository, CompanyRepository, EmployeeRepository}

  def affiliates(%{company_id: company_id}, %User{}) do
    company_id
    |> AffiliateRepository.find_affiliate_by_company_id()
    |> handle_response
  end

  def employees_by_company(%{company_id: company_id}, %User{}) do
    company_id
    |> EmployeeRepository.find_employee_by_company_id()
    |> handle_response
  end

  def employees_by_affiliate(%{affiliate_id: affiliate_id}, %User{}) do
    affiliate_id
    |> EmployeeRepository.find_employee_by_affiliate_id()
    |> handle_response
  end

  def companies(%User{}) do
    CompanyRepository.companies()
    |> handle_response
  end

  def handle_response(resource), do: {:ok, resource}
end
