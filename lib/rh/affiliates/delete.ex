defmodule Rh.Affiliates.Delete do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Affiliate

  def call(id) do
    case Repo.get(Affiliate, id) do
      nil -> {:error, Error.build_resource_not_found_error("Affiliate")}
      affiliates -> Repo.delete(affiliates)
    end
  end
end
