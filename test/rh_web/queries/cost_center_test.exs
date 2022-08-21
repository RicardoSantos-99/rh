defmodule RhWeb.Queries.CostCenterTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @get_cost_center_by_id """
    query getCostCenter($id: UUID4!) {
      getCostCenter(id: $id) {
        id
        code
        name
      }
    }
  """

  @get_cost_centers """
    query listCostCenters {
      listCostCenters {
        code
        name
        description
      }
    }
  """

  describe "departments queries" do
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
    test "find departments by id, return a department", %{conn: conn, cost_center_id: id} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_cost_center_by_id,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getCostCenter" => %{
            "code" => "2",
            "id" => id,
            "name" => "Engenharia"
          }
        }
      }

      assert expected_response == response
    end

    @tag :skip
    test "find all departments, should return a list of departments", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_cost_centers
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "listCostCenters" => [
            %{
              "code" => "2",
              "description" => "Engenharia de software",
              "name" => "Engenharia"
            }
          ]
        }
      }

      assert expected_response == response
    end
  end
end
