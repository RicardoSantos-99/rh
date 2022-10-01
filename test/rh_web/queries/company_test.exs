defmodule RhWeb.Queries.CompanyTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  alias Support.Fixtures.Setup
  alias Rh.Schema.{Company, User}

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
      %{token: token} = Setup.add_user()

      {:ok, %Company{id: company_id, cnpj: cnpj}} =
        :company
        |> build()
        |> Rh.create_company(%User{})

      %{conn: conn, company_id: company_id, token: token, cnpj: cnpj}
    end

    test "find company by id, return company", %{conn: conn, company_id: company_id, token: token} do
      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> post("/api/graphql", %{
          "query" => @get_company_by_id,
          "variables" => %{id: company_id}
        })
        |> json_response(:ok)

      assert response == %{
               "data" => %{
                 "getCompany" => %{
                   "cnpj" => "12312312312312",
                   "corporateName" => "RH",
                   "id" => company_id,
                   "name" => "ninho de camundangas"
                 }
               }
             }
    end

    test "find company by cnpj, return company", %{
      conn: conn,
      token: token,
      cnpj: cnpj,
      company_id: id
    } do
      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
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

    test "find all companies, return a list of all companies", %{
      conn: conn,
      token: token,
      company_id: id
    } do
      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
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
