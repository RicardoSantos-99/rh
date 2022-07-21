defmodule Rh.Occupations.List do
  alias Rh.{Repo}
  alias Rh.Schema.Occupation

  def call() do
    Repo.all(Occupation)
    |> handle_response()
  end

  defp handle_response(occupations), do: {:ok, occupations}
end
