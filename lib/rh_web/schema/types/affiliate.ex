defmodule RhWeb.Schema.Types.Affiliate do
  @moduledoc """
  This module defines the affiliate types.
  """

  use Absinthe.Schema.Notation

  object :affiliate do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :cnpj, non_null(:string)
    field :company_id, non_null(:uuid4)
  end

  input_object :create_affiliate_input do
    field :name, non_null(:string)
    field :cnpj, non_null(:string)
  end
end
