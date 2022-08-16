defmodule RhWeb.Queries.Employee do
  @moduledoc """
  employee queries.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Employee, as: EmployeeResolver

  object :employee_queries do
    field :get_employee, type: :employee do
      arg :id, non_null(:uuid4)

      resolve &EmployeeResolver.get/3
    end

    field :list_employees, list_of(:employee) do
      resolve &EmployeeResolver.list/3
    end

    field :login, type: :string do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&EmployeeResolver.login/2)
    end
  end
end
