defmodule RhWeb.Queries.CompanyTest do
  use RhWeb.ConnCase, async: true

  @get_company_by_id """
    query getCompany($id: UUID4!) {
      getCompany(id: $id) {
        cnpj
        corporateName
        id
        name
      }
    }
  """

  describe "Company queries" do
    setup %{} do
    end
  end
end
