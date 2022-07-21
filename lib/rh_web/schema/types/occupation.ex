defmodule RhWeb.Schema.Types.Occupation do
  use Absinthe.Schema.Notation

  object :occupation do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:integer)
    field :company_id, non_null(:uuid4)
  end

  input_object :create_occupation_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:integer)
    field :company_id, non_null(:uuid4)
  end
end
