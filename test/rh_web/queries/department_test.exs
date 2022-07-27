defmodule RhWeb.Queries.DepartmentTest do
  use RhWeb.ConnCase, async: true

  describe "Company" do
    test "when all params are valid, create a new company", %{conn: conn} do
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

    test "when cnpj is invalid format, returns an error", %{conn: conn} do
      mutation = """
      mutation createCompany {
        createCompany(
          input: {
            cnpj: "1231231231231",
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

      expected_response = %{
        "data" => %{"createCompany" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "cnpj should be 14 character(s)",
            "path" => ["createCompany"]
          }
        ]
      }

      assert expected_response == response
    end

    test "when already exist company, returns an error", %{conn: conn} do
      company = %{cnpj: "12312312312312", corporate_name: "RH", name: "ninho de camundangas"}
      Rh.create_company(company)

      mutation = """
      mutation createCompany {
        createCompany(
          input: {
            cnpj: "12312312312312",
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

      expected_response = %{
        "data" => %{"createCompany" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "cnpj has already been taken",
            "path" => ["createCompany"]
          }
        ]
      }

      assert expected_response == response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      mutation = """
        mutation createCompany {
          createCompany(
            input: {
              cnpj: "12312312312312",
              teste: "coks",
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

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 7, "line" => 3}],
            "message" =>
              "Argument \"input\" has invalid value {cnpj: \"12312312312312\", teste: \"coks\", name: \"cola coka\"}.\nIn field \"corporateName\": Expected type \"String!\", found null.\nIn field \"teste\": Unknown field."
          }
        ]
      }

      assert expected_response == response
    end
  end
end
