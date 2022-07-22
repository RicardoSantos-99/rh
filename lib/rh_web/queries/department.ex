defmodule RhWeb.Queries.Department do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Department, as: DepartmentResolver

  object :department_queries do
    field :get_department, type: :department do
      arg :id, non_null(:uuid4)

      resolve &DepartmentResolver.get/2
    end

    field :get_department_by_code, type: :department do
      arg :code, non_null(:string)

      resolve &DepartmentResolver.get_by_code/2
    end

    field :list_departments, list_of(:department) do
      resolve &DepartmentResolver.list/2
    end
  end
end
