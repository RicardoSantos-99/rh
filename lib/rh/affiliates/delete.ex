defmodule Rh.Affiliates.Delete do
  @moduledoc """
  Delete an affiliate.
  """
  alias Rh.Repo
  alias Rh.Schema.Affiliate

  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Affiliate, id) do
      nil -> {:error, "Affiliate not found"}
      affiliates -> Repo.delete(affiliates)
    end
  end
end
