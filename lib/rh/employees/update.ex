defmodule Rh.Employees.Update do
  alias Rh.Repo
  alias Rh.Schema.Employee

  def store_token(%Employee{} = employee, token) do
    Ecto.Changeset.change(employee, %{token: token})
    |> Repo.update()
  end

  def revoke_token(current_user) do
    Ecto.Changeset.change(current_user, %{token: nil})
    |> Repo.update()
  end
end
