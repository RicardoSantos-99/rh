defmodule RhWeb.Queries.DepartmentTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @get_department_by_id """
    query getDepartment($id: UUID4!) {
      getDepartment(id: $id) {
        id
        code
        name
      }
    }
  """

  @get_departments """
    query listDepartments {
      listDepartments {
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

      {:ok, %{id: company_id}} = Rh.create_company(company)

      affiliated_params = build(:affiliated, %{company_id: company_id})
      {:ok, %{id: affiliated_id}} = Rh.create_affiliate(affiliated_params, employee)

      cost_center_params = build(:cost_center, %{affiliate_id: affiliated_id})
      {:ok, %{id: cost_center_id}} = Rh.create_cost_center(cost_center_params)

      department_params = build(:department, %{cost_center_id: cost_center_id})
      {:ok, %{id: department_id}} = Rh.create_department(department_params)

      {:ok, conn: conn, department_id: department_id}
    end

    @tag :skip
    test "find departments by id, return a department", %{conn: conn, department_id: id} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_department_by_id,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getDepartment" => %{
            "code" => "1",
            "id" => id,
            "name" => "Desenvolvimento"
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
          "query" => @get_departments
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "listDepartments" => [
            %{
              "code" => "1",
              "description" => "Desenvolvimento de software",
              "name" => "Desenvolvimento"
            }
          ]
        }
      }

      assert expected_response == response
    end
  end
end
