defmodule Rh.Occupations.Create do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Occupation

  def call(params) do
    params
    |> Occupation.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Occupation{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
