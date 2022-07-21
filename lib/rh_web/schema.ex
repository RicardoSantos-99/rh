defmodule RhWeb.Schema do
  use Absinthe.Schema

  import_types RhWeb.Schema.Types.Custom.UUID4

  import_types RhWeb.Schema.Types.Company
  import_types RhWeb.Mutations.Company
  import_types RhWeb.Queries.Company

  import_types RhWeb.Schema.Types.Occupation
  import_types RhWeb.Mutations.Occupation
  import_types RhWeb.Queries.Occupation

  query do
    import_fields :company_queries
    import_fields :occupation_queries
  end

  mutation do
    import_fields :company_mutation
    import_fields :occupation_mutation
  end
end
