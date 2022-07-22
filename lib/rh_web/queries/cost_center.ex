defmodule RhWeb.Queries.CostCenter do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.CostCenter, as: CostCenterResolver

  object :cost_center_queries do
    field :get_cost_center, type: :cost_center do
      arg :id, non_null(:uuid4)

      resolve &CostCenterResolver.get/2
    end

    field :get_cost_center_by_code, type: :cost_center do
      arg :code, non_null(:string)

      resolve &CostCenterResolver.get_by_code/2
    end

    field :list_cost_centers, list_of(:cost_center) do
      resolve &CostCenterResolver.list/2
    end
  end
end
