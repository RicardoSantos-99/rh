defmodule Rh.Companies.Create do
  @moduledoc """
  Create a company.
  """

  alias Rh.Repo
  alias Rh.Schema.Company

  def call(params) do
    params
    |> Company.changeset()
    |> Repo.insert()
  end
end
