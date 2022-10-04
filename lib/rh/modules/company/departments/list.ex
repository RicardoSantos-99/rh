defmodule Rh.Modules.Company.Departments.List do
  @moduledoc """
  List departments.
  """
  alias Rh.Repo
  alias Rh.Schema.Department

  def call do
    Repo.all(Department)
    |> handle_response()
  end

  defp handle_response(departments), do: {:ok, departments}
end
