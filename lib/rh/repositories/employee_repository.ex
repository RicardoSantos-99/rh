defmodule Rh.Repositories.EmployeeRepository do
  import Ecto.Query

  alias Rh.Repo
  alias Rh.Schema.Employee

  def find_employee_by_id(employee_id) do
    Repo.one(
      from a in Employee,
        where: a.id == ^employee_id
    )
  end

  def find_employee_by_email(email) do
    Repo.one(
      from a in Employee,
        where: a.email == ^email
    )
  end

  def find_employee_by_company_id(company_id) do
    Repo.all(
      from a in Employee,
        where: a.company_id == ^company_id
    )
  end

  def find_employee_by_affiliate_id(affiliate_id) do
    Repo.all(
      from a in Employee,
        where: a.affiliate_id == ^affiliate_id
    )
  end

  def remove_employee_by_id(employee_id) do
    Repo.delete_all(
      from a in Employee,
        where: a.id == ^employee_id
    )
  end
end
