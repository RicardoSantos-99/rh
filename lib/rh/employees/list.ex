defmodule Rh.Employees.List do
  alias Rh.Repo
  alias Rh.Schema.Employee

  def call(_current_user) do
    Repo.all(Employee)
    |> handle_response()
  end

  defp handle_response(employees), do: {:ok, employees}
end
