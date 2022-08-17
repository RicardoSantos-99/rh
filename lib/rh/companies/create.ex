defmodule Rh.Companies.Create do
  @moduledoc """
  Create a company.
  """

  alias Rh.Repo
  alias Rh.Schema.{Company, User}

  def call(params, %User{}) do
    params
    |> Company.changeset()
    |> Repo.insert()
  end

  def call(_params, _), do: {:error, "Access denied"}
end
