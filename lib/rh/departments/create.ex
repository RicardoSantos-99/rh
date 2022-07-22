defmodule Rh.Departments.Create do
  alias Rh.Repo
  alias Rh.Schema.Department

  def call(params) do
    params
    |> Department.changeset()
    |> Repo.insert()
  end
end
