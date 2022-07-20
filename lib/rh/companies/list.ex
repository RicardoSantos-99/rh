defmodule Rh.Companies.List do
  alias Rh.{Repo}
  alias Rh.Schema.Company

  def call() do
    companies = Repo.all(Company)

    {:ok, companies}
  end
end
