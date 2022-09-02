defmodule Rh.Employees.Create do
  alias Rh.Repo
  alias Rh.Schema.Employee
  alias Rh.Utils.Auth

  def call(params, %Employee{company_id: company_id, affiliate_id: affiliate_id} = current_user) do
    case Auth.check_access(company_id, current_user, :ADMIN) do
      {:ok, _id} ->
        Map.merge(params, %{company_id: company_id, affiliate_id: affiliate_id})
        |> handle_insert
        |> notify_employee_created

      {:error, message} ->
        {:error, message}

      :error ->
        {:error, "Invalid UUID"}
    end
  end

  defp handle_insert(params) do
    {:ok, password} = Passgen.create!(length: 12)

    Map.put(params, :password, password)
    |> Employee.changeset()
    |> Repo.insert()
  end

  def notify_employee_created({:ok, params}) do
    params
    |> Rh.UserEmail.send_email()
    |> Rh.Mailer.deliver()

    {:ok, params}
  end
end
