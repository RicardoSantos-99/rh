defmodule Rh.Error do
  @moduledoc """
  Handle errors.
  """
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_resource_not_found_error(resource_name),
    do: build(:not_found, "#{resource_name} not found")
end
