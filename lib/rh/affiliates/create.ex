defmodule Rh.Affiliates.Create do
  @moduledoc """
  Create an affiliate.
  """
  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.Affiliate
  alias Rh.Utils.Auth

  def call(params, %{company_id: company_id} = current_user) do
    with {:ok, _id} <- Auth.check_access(company_id, current_user, :ADMIN),
         {:ok, _uuid} <- UUID.cast(company_id) do
      params
      |> Map.put_new(:company_id, company_id)
      |> handle_insert()
    else
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end

  defp handle_insert(params) do
    params
    |> Affiliate.changeset()
    |> Repo.insert()
  end
end
