defmodule Rh.Occupations.List do
  @moduledoc """
  List occupations.
  """
  alias Rh.Repo
  alias Rh.Schema.Occupation

  def call do
    Repo.all(Occupation)
    |> handle_response()
  end

  defp handle_response(occupations), do: {:ok, occupations}
end
