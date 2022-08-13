defmodule Rh.Utils.Auth do
  import Ecto.Query

  alias Rh.Repo
  alias Rh.Schema.{Company, Employee}

  @permissions %{
    :VALIDATOR => 0,
    :RECRUIT => 1,
    :MANAGER => 2,
    :ADMIN => 3
  }

  def check_access(id, %Employee{company_id: user_company_id, employee: employee_auth}, auth) do
    with company_id <- Repo.one(from a in Company, where: a.id == ^id, select: a.id),
         true <- check_company(company_id, user_company_id),
         :permitted <- has_permission(employee_auth, auth) do
      {:ok, company_id}
    else
      nil -> {:error, "Company not found"}
      false -> {:error, "Requested company does not match user's company"}
      :no_permission -> {:error, "User does not have permission"}
    end
  end

  defp check_company(company_id, user_company_id), do: company_id == user_company_id

  def has_permission(employee_auth, auth) do
    if @permissions[employee_auth] >= @permissions[auth] do
      :permitted
    else
      :no_permission
    end
  end
end
