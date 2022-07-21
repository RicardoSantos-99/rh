defmodule Rh.Occupations.Delete do
  alias Rh.Repo
  alias Rh.Schema.Occupation

  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Occupation, id) do
      nil -> {:error, "Occupation not found"}
      occupation -> Repo.delete(occupation)
    end
  end
end
