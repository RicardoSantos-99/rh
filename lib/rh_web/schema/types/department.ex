defmodule RhWeb.Schema.Types.Department do
  use Absinthe.Schema.Notation

  object :department do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:string)
    field :cost_center_id, non_null(:uuid4)
  end

  input_object :create_department_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :code, non_null(:string)
    field :cost_center_id, non_null(:uuid4)
  end
end
