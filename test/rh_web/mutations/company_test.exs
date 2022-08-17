defmodule RhWeb.Mutations.CompanyTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  alias Rh.Schema.Company

  @create_company """
    mutation createCompany($input: CreateCompanyInput!) {
      createCompany(input: $input) {
        id
        cnpj
        corporateName
        name
      }
    }
  """

  @delete_company """
    mutation deleteCompany($id: UUID4!) {
      deleteCompany(id: $id) {
        id
      }
    }
  """
  @tag :skip
  describe "create company mutations" do
    @tag :skip
    test "when all params are valid, create a new company", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_company,
            "variables" => %{
              input: %{
                cnpj: "12312312312313",
                corporateName: "coks",
                name: "cola coka"
              }
            }
          }
        )
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

    @tag :skip
    test "when cnpj is invalid format, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @create_company,
          "variables" => %{
            input: %{
              cnpj: "1231231231231",
              corporateName: "coks",
              name: "cola coka"
            }
          }
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createCompany" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "cnpj should be 14 character(s)",
            "path" => ["createCompany"]
          }
        ]
      }

      assert expected_response == response
    end

    @tag :skip
    test "when already exist company, returns an error", %{conn: conn} do
      company = %{cnpj: "12312312312312", corporate_name: "RH", name: "ninho de camundangas"}
      Rh.create_company(company, %{})

      response =
        conn
        |> post("/api/graphql", %{
          "query" => @create_company,
          "variables" => %{
            input: %{cnpj: "12312312312312", corporateName: "coks", name: "cola coka"}
          }
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createCompany" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "cnpj has already been taken",
            "path" => ["createCompany"]
          }
        ]
      }

      assert expected_response == response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @create_company,
          "variables" => %{input: %{cnpj: "12312312312312", teste: "coks", name: "cola coka"}}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 19, "line" => 2}],
            "message" =>
              "Argument \"input\" has invalid value $input.\nIn field \"corporateName\": Expected type \"String!\", found null.\nIn field \"teste\": Unknown field."
          }
        ]
      }

      assert expected_response == response
    end
  end

  @tag :skip
  describe "delete company mutations" do
    test "when id is valid, return ok", %{conn: conn} do
      company = build(:company)
      {:ok, %Company{id: company_id}} = Rh.create_company(company, %{})

      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_company,
          "variables" => %{id: company_id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteCompany" => %{"id" => company_id}}
      }

      assert expected_response == response
    end

    test "when id is invalid uuid, return an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_company,
          "variables" => %{id: "12312312312312"}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 19, "line" => 2}],
            "message" => "Argument \"id\" has invalid value $id."
          }
        ]
      }

      assert expected_response == response
    end

    @tag :skip
    test "when company not found, return an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_company,
          "variables" => %{id: Ecto.UUID.generate()}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteCompany" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "Company not found",
            "path" => ["deleteCompany"]
          }
        ]
      }

      assert expected_response == response
    end

    test "when there are invalid params, return an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_company
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 19, "line" => 2}],
            "message" => "In argument \"id\": Expected type \"UUID4!\", found null."
          },
          %{
            "locations" => [%{"column" => 26, "line" => 1}],
            "message" => "Variable \"id\": Expected non-null, found null."
          }
        ]
      }

      assert expected_response == response
    end
  end
end
