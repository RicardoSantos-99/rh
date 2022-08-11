defmodule Rh.Affiliates.Get do
  @moduledoc """
  Get an affiliate.
  """
  alias Rh.Repo
  alias Rh.Schema.Affiliate

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Affiliate, id) do
      nil -> {:error, "Affiliate not found"}
      affiliates -> {:ok, affiliates}
    end
  end
end
