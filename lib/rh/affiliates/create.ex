defmodule Rh.Affiliates.Create do
  alias Rh.Repo
  alias Rh.Schema.Affiliate

  def call(params) do
    params
    |> Affiliate.changeset()
    |> Repo.insert()
  end
end
