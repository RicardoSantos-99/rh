defmodule Rh.Companies.List do
  alias Rh.{Repo}
  alias Rh.Schema.Company

  def call() do
    Repo.all(Company)
    |> handle_response()
  end

  defp handle_response(companies), do: {:ok, companies}
end
