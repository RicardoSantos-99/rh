defmodule Rh.Employees.Update do
  alias Rh.Repo
  alias Rh.Schema.Employee

  def store_token(%Employee{} = employee, token) do
    Ecto.Changeset.change(employee, %{token: token})
    |> Repo.update()
  end
end
