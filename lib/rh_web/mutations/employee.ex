defmodule RhWeb.Mutations.Employee do
  @moduledoc """
  employee mutations.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Employee, as: EmployeeResolver

  alias Crudry.Middlewares.TranslateErrors

  object :employee_mutation do
    field :create_employee, type: :employee_output do
      arg :input, non_null(:create_employee_input)

      resolve &EmployeeResolver.create/3
      middleware TranslateErrors
    end

    field :delete_employee, type: :employee do
      arg :id, non_null(:uuid4)

      resolve &EmployeeResolver.delete/3
      middleware TranslateErrors
    end

    field :login, type: :token do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve &EmployeeResolver.login/2
      middleware TranslateErrors
    end

    field :logout, type: :token do
      resolve &EmployeeResolver.logout/2
      middleware TranslateErrors
    end
  end
end
