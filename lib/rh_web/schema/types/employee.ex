defmodule RhWeb.Schema.Types.Employee do
  @moduledoc """
  This module defines the employees.
  """

  use Absinthe.Schema.Notation

  enum :employees_type do
    value :VALIDATOR
    value :RECRUIT
    value :MANAGER
    value :ADMIN
  end

  object :employee do
    field :id, non_null(:uuid4)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :name, non_null(:string)
    field :cpf, non_null(:string)
    field :token, non_null(:string)
    field :employees_type, non_null(:employees_type)
  end

  input_object :create_employee_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :name, non_null(:string)
    field :cpf, non_null(:string)
    field :type, non_null(:employees_type)
  end

  object :token do
    field :token, :string
  end
end
