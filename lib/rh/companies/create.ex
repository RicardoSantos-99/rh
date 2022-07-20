defmodule Rh.Companies.Create do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Company

  def call(params) do
    params
    |> Company.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Company{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
