defmodule RhWeb.Mutations.OccupationTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @create_occupation """
    mutation createOccupation($input: CreateOccupationInput!) {
      createOccupation(input: $input) {
        id
        name
      }
    }
  """

  @delete_occupation """
    mutation deleteOccupation($id: UUID4!) {
      deleteOccupation(id: $id) {
        id
      }
    }
  """

  describe "create occupation mutations" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, conn: conn, company: company}
    end

    test "when all params are valid, create a new occupation", %{conn: conn, company: %{id: id}} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_occupation,
            "variables" => %{
              input: %{
                name: "QA",
                description: "Qualidade de software",
                code: 2,
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{"data" => %{"createOccupation" => %{"id" => _id, "name" => "QA"}}} = response
    end

    test "when occupation name already exist, return an error", %{conn: conn, company: %{id: id}} do
      build(:occupation, %{company_id: id}) |> Rh.create_occupation()

      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_occupation,
            "variables" => %{
              input: %{
                name: "QA",
                description: "Qualidade de software",
                code: 2,
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createOccupation" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "name has already been taken",
                   "path" => ["createOccupation"]
                 }
               ]
             } = response
    end

    test "when company id does not exist, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_occupation,
            "variables" => %{
              input: %{
                name: "QA",
                description: "Qualidade de software",
                code: 2,
                company_id: Ecto.UUID.generate()
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createOccupation" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "Company not found",
                   "path" => ["createOccupation"]
                 }
               ]
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_occupation,
            "variables" => %{
              input: %{
                name: "QA",
                description: "Qualidade de software",
                code: 2,
                teste: "123",
                company_id: "id"
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "errors" => [
                 %{
                   "locations" => [%{"column" => 22, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"company_id\": Expected type \"UUID4!\", found \"id\".\nIn field \"teste\": Unknown field."
                 }
               ]
             } = response
    end
  end

  describe "delete occupation mutations" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, occupation} =
        build(:occupation, %{company_id: company.id})
        |> Rh.create_occupation()

      {:ok, conn: conn, occupation: occupation}
    end

    test "when id is valid, delete an occupation", %{conn: conn, occupation: %{id: occupation_id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_occupation,
          "variables" => %{id: occupation_id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteOccupation" => %{"id" => occupation_id}}
      }

      assert expected_response == response
    end

    test "when id is invalid uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_occupation,
          "variables" => %{id: "occupation_id"}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 22, "line" => 2}],
            "message" => "Argument \"id\" has invalid value $id."
          }
        ]
      }

      assert expected_response == response
    end

    test "when occupation not found, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_occupation,
          "variables" => %{id: Ecto.UUID.generate()}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "Occupation not found",
            "path" => ["deleteOccupation"]
          }
        ],
        "data" => %{"deleteOccupation" => nil}
      }

      assert expected_response == response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_occupation
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 22, "line" => 2}],
            "message" => "In argument \"id\": Expected type \"UUID4!\", found null."
          },
          %{
            "locations" => [%{"column" => 29, "line" => 1}],
            "message" => "Variable \"id\": Expected non-null, found null."
          }
        ]
      }

      assert expected_response == response
    end
  end
end
