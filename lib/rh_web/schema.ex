defmodule RhWeb.Schema do
  use Absinthe.Schema

  import_types RhWeb.Schema.Types.Company
  import_types RhWeb.Mutations.Company
  import_types RhWeb.Queries.Company

  query do
    import_fields :company_queries
  end

  mutation do
    import_fields :company_mutation
  end
end
