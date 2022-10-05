defmodule RhWeb.Queries.AffiliatedTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @get_affiliate_by_id """
    query getAffiliate($id: UUID4!) {
      getAffiliate(id: $id) {
        id
        cnpj
        name
      }
    }
  """

  @get_affiliates """
    query listAffiliates {
      listAffiliates {
        cnpj
        name
      }
    }
  """

  describe "affiliate queries" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, affiliate} =
        build(:affiliated, %{company_id: company.id})
        |> Rh.create_affiliate(build(:employee))

      {:ok, conn: conn, affiliate: affiliate}
    end

    @tag :skip
    test "find affiliate by id, return an affiliate", %{
      conn: conn,
      affiliate: %{id: id, cnpj: cnpj}
    } do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_affiliate_by_id,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{
                 "getAffiliate" => %{
                   "id" => id,
                   "name" => "vli",
                   "cnpj" => cnpj
                 }
               }
             }
    end

    @tag :skip
    test "find all affiliate, should return a list of affiliates", %{
      conn: conn,
      affiliate: %{cnpj: cnpj}
    } do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_affiliates
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{"listAffiliates" => [%{"cnpj" => cnpj, "name" => "vli"}]}
             }
    end
  end
end
