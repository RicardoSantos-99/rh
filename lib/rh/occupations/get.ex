defmodule Rh.Occupations.Get do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Occupation

  def by_id(id) do
    case Repo.get(Occupation, id) do
      nil -> {:error, Error.build(:not_found, "Occupation not found")}
      occupations -> {:ok, occupations}
    end
  end
end
