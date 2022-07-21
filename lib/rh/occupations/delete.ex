defmodule Rh.Occupations.Delete do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Occupation

  def call(id) do
    case Repo.get(Occupation, id) do
      nil -> {:error, Error.build_resource_not_found_error("Occupation")}
      occupations -> Repo.delete(occupations)
    end
  end
end
