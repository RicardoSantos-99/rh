defmodule Rh.Modules.Company.Departments.Create do
  @moduledoc """
  Create a department.
  """
  alias Rh.Repo
  alias Rh.Schema.{CostCenter, Department}

  alias Ecto.UUID

  def call(%{cost_center_id: cost_center_id} = params) do
    cost_center_id
    |> UUID.cast()
    |> handle_response(params)
  end

  def handle_response(:error, _params), do: {:error, "Invalid UUID"}

  def handle_response({:ok, cost_center_id}, params) do
    case Repo.get(CostCenter, cost_center_id) do
      nil -> {:error, "Cost center not found"}
      _company -> handle_insert(params)
    end
  end

  def handle_insert(params) do
    params
    |> Department.changeset()
    |> Repo.insert()
  end
end
