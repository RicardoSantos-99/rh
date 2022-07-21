defmodule Rh.Affiliates.List do
  alias Rh.{Repo}
  alias Rh.Schema.Affiliate

  def call() do
    affiliates = Repo.all(Affiliate)

    {:ok, affiliates}
  end
end
