defmodule RhWeb.Mutations.Department do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Department, as: DepartmentResolver

  alias Crudry.Middlewares.TranslateErrors

  object :department_mutation do
    field :create_department, type: :department do
      arg :input, non_null(:create_department_input)

      resolve &DepartmentResolver.create/2
      middleware TranslateErrors
    end

    field :delete_department, type: :department do
      arg :id, non_null(:uuid4)

      resolve &DepartmentResolver.delete/2
      middleware TranslateErrors
    end
  end
end
