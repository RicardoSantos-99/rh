defmodule Rh.Companies.List do
  @moduledoc """
  List companies.
  """
  alias Rh.Repo
  alias Rh.Schema.Company

  def call(_current_user) do
    Repo.all(Company)
    |> handle_response()
  end

  defp handle_response(companies), do: {:ok, companies}
end
