defmodule RhWeb.Queries.Company do
  @moduledoc """
  company queries.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Company, as: CompanyResolver

  object :company_queries do
    field :get_company, type: :company do
      arg :id, non_null(:uuid4)

      resolve &CompanyResolver.get/3
    end

    field :get_company_by_cnpj, type: :company do
      arg :cnpj, non_null(:string)

      resolve &CompanyResolver.get_by_cnpj/3
    end

    field :list_companies, list_of(:company) do
      resolve &CompanyResolver.list/2
    end
  end
end
