defmodule RhWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:uuid4)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :name, non_null(:string)
  end

  input_object :user_create_employee do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :name, non_null(:string)
    field :cpf, non_null(:string)
    field :employees_type, non_null(:employees_type)
    field :company_id, non_null(:uuid4)
    field :affiliate_id, non_null(:uuid4)
  end

  input_object :user_create_affiliate do
    field :name, non_null(:string)
    field :cnpj, non_null(:string)
    field :company_id, non_null(:uuid4)
  end

  input_object :user_create_company do
    field :name, non_null(:string)
    field :corporate_name, non_null(:string)
    field :cnpj, non_null(:string)
  end
end
