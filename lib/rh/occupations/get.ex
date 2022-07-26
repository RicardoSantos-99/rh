defmodule Rh.Occupations.Get do
  @moduledoc """
  Get an occupation.
  """

  alias Rh.Repo
  alias Rh.Schema.Occupation

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Occupation, id) do
      nil -> "Occupation not found"
      occupations -> {:ok, occupations}
    end
  end
end
