defmodule Rh.Occupations.Create do
  alias Rh.Repo
  alias Rh.Schema.Occupation

  def call(params) do
    params
    |> Occupation.changeset()
    |> Repo.insert()
  end
end
