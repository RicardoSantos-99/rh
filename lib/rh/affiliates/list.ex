defmodule Rh.Affiliates.List do
  alias Rh.{Repo}
  alias Rh.Schema.Affiliate

  def call() do
    Repo.all(Affiliate)
    |> handle_response()
  end

  defp handle_response(affiliates), do: {:ok, affiliates}
end
