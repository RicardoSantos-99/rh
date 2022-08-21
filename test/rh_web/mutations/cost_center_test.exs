defmodule RhWeb.Mutations.CostCenterTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @create_cost_center """
    mutation createCostCenter($input: CreateCostCenterInput!) {
      createCostCenter(input: $input) {
        id
        name
        description
        code
      }
    }
  """

  @delete_cost_center """
    mutation deleteCostCenter($id: UUID4!) {
      deleteCostCenter(id: $id) {
        id
      }
    }
  """

  describe "create department mutations" do
    setup %{conn: conn} do
      company = build(:company)
      employee = build(:employee)

      {:ok, %{id: company_id}} = Rh.create_company(company, %{})

      affiliated_params = build(:affiliated, %{company_id: company_id})
      {:ok, %{id: affiliated_id}} = Rh.create_affiliate(affiliated_params, employee)

      {:ok, conn: conn, affiliated_id: affiliated_id}
    end

    @tag :skip
    test "when all params are valid, create a new cost center", %{conn: conn, affiliated_id: id} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_cost_center,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "2",
                affiliate_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      _expected_response = %{
        "data" => %{
          "createCostCenter" => %{
            "code" => "2",
            "description" => "Desenvolvimento de software",
            "name" => "Desenvolvimento"
          }
        }
      }

      assert _expected_response = response
    end

    @tag :skip
    test "when cost_center id does not exist, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_cost_center,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "1",
                affiliate_id: Ecto.UUID.generate()
              }
            }
          }
        )
        |> json_response(:ok)

      assert _expected_response =
               %{
                 "errors" => [
                   %{
                     "locations" => [%{"column" => 5, "line" => 2}],
                     "message" => "Affiliate not found",
                     "path" => ["createCostCenter"]
                   }
                 ],
                 "data" => %{"createCostCenter" => nil}
               } == response
    end

    @tag :skip
    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_cost_center,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "1",
                teste: Ecto.UUID.generate()
              }
            }
          }
        )
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 22, "line" => 2}],
            "message" =>
              "Argument \"input\" has invalid value $input.\nIn field \"affiliateId\": Expected type \"UUID4!\", found null.\nIn field \"teste\": Unknown field."
          }
        ]
      }

      assert expected_response == response
    end
  end

  describe "delete department mutations" do
    setup %{conn: conn} do
      company = build(:company)
      employee = build(:employee)

      {:ok, %{id: company_id}} = Rh.create_company(company, %{})

      affiliated_params = build(:affiliated, %{company_id: company_id})
      {:ok, %{id: affiliated_id}} = Rh.create_affiliate(affiliated_params, employee)

      cost_center_params = build(:cost_center, %{affiliate_id: affiliated_id})
      {:ok, %{id: cost_center_id}} = Rh.create_cost_center(cost_center_params, %{})

      {:ok, conn: conn, cost_center_id: cost_center_id}
    end

    @tag :skip
    test "when id is valid, delete an cost center", %{conn: conn, cost_center_id: id} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_cost_center,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteCostCenter" => %{"id" => id}}
      }

      assert expected_response == response
    end

    @tag :skip
    test "when id is invalid uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_cost_center,
          "variables" => %{id: "department_id"}
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

    @tag :skip
    test "when affiliated not found, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_cost_center,
          "variables" => %{id: Ecto.UUID.generate()}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteCostCenter" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "Cost center not found",
            "path" => ["deleteCostCenter"]
          }
        ]
      }

      assert expected_response == response
    end

    @tag :skip
    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_cost_center
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
