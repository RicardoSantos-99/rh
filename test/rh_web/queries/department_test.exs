defmodule RhWeb.Queries.DepartmentTest do
  use RhWeb.ConnCase, async: true

  alias Rh.Schema.Company

  describe "Company" do
    test "when valid params, create a new company", %{conn: conn} do
      mutation = """
      mutation createCompany {
        createCompany(
          input: {
            cnpj: "12312312312313",
            corporateName: "coks",
            name: "cola coka"
          }
        ) {
          id
          cnpj
          corporateName
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{"query" => mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createCompany" => %{
                   "cnpj" => "12312312312313",
                   "corporateName" => "coks",
                   "id" => _id,
                   "name" => "cola coka"
                 }
               }
             } = response
    end
  end
end
