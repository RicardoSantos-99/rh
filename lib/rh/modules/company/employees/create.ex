defmodule Rh.Modules.Company.Employees.Create do
  alias Rh.{Mailer, Repo}
  alias Rh.Schema.Employee
  alias Rh.Utils.Auth
  alias Rh.Utils.UserEmail

  def call(params, %Employee{company_id: company_id, affiliate_id: affiliate_id} = current_user) do
    case Auth.check_access(current_user, :ADMIN) do
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
    |> UserEmail.send_email()
    |> Mailer.deliver()

    {:ok, params}
  end
end
