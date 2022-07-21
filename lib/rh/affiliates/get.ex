defmodule Rh.Affiliates.Get do
  alias Rh.{Repo, Error}
  alias Rh.Schema.Affiliate

  def by_id(id) do
    case Repo.get(Affiliate, id) do
      nil -> {:error, Error.build(:not_found, "Affiliate not found")}
      affiliates -> {:ok, affiliates}
    end
  end
end
