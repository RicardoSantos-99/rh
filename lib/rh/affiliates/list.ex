defmodule Rh.Affiliates.List do
  @moduledoc """
  List affiliates.
  """
  import Ecto.Query, only: [where: 2]
  alias Rh.Repo
  alias Rh.Schema.{Affiliate, Employee}

  def call(%Employee{company_id: company_id}) do
    Affiliate
    |> where(company_id: ^company_id)
    |> Repo.all()
    |> handle_response()
  end

  defp handle_response(affiliates), do: {:ok, affiliates}
end
