defmodule Rh.Employees.Create do
  alias Rh.Repo
  alias Rh.Schema.Employee
  alias Rh.Utils.Auth

  alias Ecto.UUID

  def call(%{affiliate_id: affiliate_id} = params, %{company_id: company_id} = current_user) do
    with {:ok, _id} <- Auth.check_access(company_id, current_user, :ADMIN),
         {:ok, _uuid} <- UUID.cast(affiliate_id) do
      params
      |> handle_insert()
    else
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end

  defp handle_insert(params) do
    params
    |> Employee.changeset()
    |> Repo.insert()
  end
end
