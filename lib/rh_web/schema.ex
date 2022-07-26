defmodule RhWeb.Schema do
  @moduledoc """
  schema for the RhWeb API.
  """

  use Absinthe.Schema

  import_types RhWeb.Schema.Types.Custom.UUID4

  import_types RhWeb.Schema.Types.Company
  import_types RhWeb.Mutations.Company
  import_types RhWeb.Queries.Company

  import_types RhWeb.Schema.Types.Occupation
  import_types RhWeb.Mutations.Occupation
  import_types RhWeb.Queries.Occupation

  import_types RhWeb.Schema.Types.Affiliate
  import_types RhWeb.Mutations.Affiliate
  import_types RhWeb.Queries.Affiliate

  import_types RhWeb.Schema.Types.Department
  import_types RhWeb.Mutations.Department
  import_types RhWeb.Queries.Department

  import_types RhWeb.Schema.Types.CostCenter
  import_types RhWeb.Mutations.CostCenter
  import_types RhWeb.Queries.CostCenter

  query do
    import_fields :company_queries
    import_fields :occupation_queries
    import_fields :affiliate_queries
    import_fields :department_queries
    import_fields :cost_center_queries
  end

  mutation do
    import_fields :company_mutation
    import_fields :occupation_mutation
    import_fields :affiliate_mutation
    import_fields :department_mutation
    import_fields :cost_center_mutation
  end
end
