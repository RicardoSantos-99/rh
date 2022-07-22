defmodule RhWeb.Mutations.CostCenter do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.CostCenter, as: CostCenterResolver

  alias Crudry.Middlewares.TranslateErrors

  object :cost_center_mutation do
    field :create_cost_center, type: :cost_center do
      arg :input, non_null(:create_cost_center_input)

      resolve &CostCenterResolver.create/2
      middleware TranslateErrors
    end

    field :delete_cost_center, type: :cost_center do
      arg :id, non_null(:uuid4)

      resolve &CostCenterResolver.delete/2
      middleware TranslateErrors
    end
  end
end
