defmodule RhWeb.Queries.CompanyTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

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

  @get_company_by_cnpj """
    query getCompanyByCnpj($cnpj: String!) {
      getCompanyByCnpj(cnpj: $cnpj) {
        corporateName
        cnpj
        name
        id
      }
    }
  """

  @list_companies """
    query listCompanies {
      listCompanies {
        corporateName
        cnpj
        name
        id
      }
    }
  """

  describe "Company queries" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params, %{})

      {:ok, conn: conn, company: company}
    end

    @tag :skip
    test "find company by id, return company", %{conn: conn, company: %{id: id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_company_by_id,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{
                 "getCompany" => %{
                   "cnpj" => "12312312312312",
                   "corporateName" => "RH",
                   "id" => id,
                   "name" => "ninho de camundangas"
                 }
               }
             }
    end

    @tag :skip
    test "find company by cnpj, return company", %{conn: conn, company: %{cnpj: cnpj, id: id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_company_by_cnpj,
          "variables" => %{cnpj: cnpj}
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{
                 "getCompanyByCnpj" => %{
                   "cnpj" => "12312312312312",
                   "corporateName" => "RH",
                   "id" => id,
                   "name" => "ninho de camundangas"
                 }
               }
             }
    end

    @tag :skip
    test "find all companies, return a list of all companies", %{conn: conn, company: %{id: id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @list_companies
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{
                 "listCompanies" => [
                   %{
                     "cnpj" => "12312312312312",
                     "corporateName" => "RH",
                     "id" => id,
                     "name" => "ninho de camundangas"
                   }
                 ]
               }
             }
    end
  end
end
