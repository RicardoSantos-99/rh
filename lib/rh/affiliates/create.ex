defmodule Rh.Affiliates.Create do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Affiliate

  def call(params) do
    params
    |> Affiliate.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Affiliate{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
