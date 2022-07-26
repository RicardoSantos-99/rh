defmodule RhWeb.Schema.Types.CostCenter do
  @moduledoc """
  This module defines the cost center types.
  """

  use Absinthe.Schema.Notation

  object :cost_center do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:string)
    field :affiliate_id, non_null(:uuid4)
  end

  input_object :create_cost_center_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:string)
    field :affiliate_id, non_null(:uuid4)
  end
end
