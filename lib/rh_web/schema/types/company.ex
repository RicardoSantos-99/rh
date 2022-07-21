defmodule RhWeb.Schema.Types.Company do
  use Absinthe.Schema.Notation

  object :company do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :corporate_name, non_null(:string)
    field :cnpj, non_null(:string)
  end

  input_object :create_company_input do
    field :name, non_null(:string)
    field :corporate_name, non_null(:string)
    field :cnpj, non_null(:string)
  end
end
