defmodule Rh.Occupations.List do
  alias Rh.{Repo}
  alias Rh.Schema.Occupation

  def call() do
    occupations = Repo.all(Occupation)

    {:ok, occupations}
  end
end
