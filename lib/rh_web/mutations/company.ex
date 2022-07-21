defmodule RhWeb.Mutations.Company do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Company, as: CompanyResolver

  alias Crudry.Middlewares.TranslateErrors

  object :company_mutation do
    field :create_company, type: :company do
      arg :input, non_null(:create_company_input)

      resolve &CompanyResolver.create/2
      middleware TranslateErrors
    end

    field :delete_company, type: :company do
      arg :id, non_null(:uuid4)

      resolve &CompanyResolver.delete/2
      middleware TranslateErrors
    end
  end
end
