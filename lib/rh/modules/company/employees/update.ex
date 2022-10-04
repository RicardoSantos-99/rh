defmodule Rh.Modules.Company.Employees.Update do
  alias Ecto.Changeset
  alias Rh.Repo
  alias Rh.Schema.Employee

  def store_token(%Employee{} = employee, token) do
    Changeset.change(employee, %{token: token})
    |> Repo.update()
  end

  def revoke_token(current_user) do
    Changeset.change(current_user, %{token: nil})
    |> Repo.update()
  end
end
