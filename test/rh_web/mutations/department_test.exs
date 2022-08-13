defmodule RhWeb.Mutations.DepartmentTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @create_department """
    mutation createDepartment($input: CreateDepartmentInput!) {
      createDepartment(input: $input) {
        id
        name
        description
        code
      }
    }
  """

  @delete_department """
    mutation deleteDepartment($id: UUID4!) {
      deleteDepartment(id: $id) {
        id
      }
    }
  """

  describe "create department mutations" do
    setup %{conn: conn} do
      company = build(:company)
      employee = build(:employee)

      {:ok, %{id: company_id}} = Rh.create_company(company)

      affiliated_params = build(:affiliated, %{company_id: company_id})
      {:ok, %{id: affiliated_id}} = Rh.create_affiliate(affiliated_params, employee)

      cost_center_params = build(:cost_center, %{affiliate_id: affiliated_id})
      {:ok, %{id: cost_center_id}} = Rh.create_cost_center(cost_center_params)

      {:ok, conn: conn, cost_center_id: cost_center_id}
    end

    @tag :skip
    test "when all params are valid, create a new department", %{conn: conn, cost_center_id: id} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_department,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "2",
                cost_center_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createDepartment" => %{
                   "code" => "2",
                   "description" => "Desenvolvimento de software",
                   "id" => _id,
                   "name" => "Desenvolvimento"
                 }
               }
             } = response
    end

    @tag :skip
    test "when department code already exist, return an error", %{conn: conn, cost_center_id: id} do
      build(:department, %{cost_center_id: id}) |> Rh.create_department()

      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_department,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "1",
                cost_center_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createDepartment" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "code has already been taken",
                   "path" => ["createDepartment"]
                 }
               ]
             } = response
    end

    @tag :skip
    test "when cost_center_id id does not exist, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_department,
            "variables" => %{
              input: %{
                name: "Desenvolvimento",
                description: "Desenvolvimento de software",
                code: "1",
                cost_center_id: Ecto.UUID.generate()
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createDepartment" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "Cost center not found",
                   "path" => ["createDepartment"]
                 }
               ]
             } == response
    end

    @tag :skip
    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_department,
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

      assert %{
               "errors" => [
                 %{
                   "locations" => [%{"column" => 22, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"costCenterId\": Expected type \"UUID4!\", found null.\nIn field \"teste\": Unknown field. Did you mean \"cost_center_id\"?"
                 }
               ]
             } == response
    end
  end

  describe "delete department mutations" do
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
    test "when id is valid, delete an affiliate", %{conn: conn, department_id: id} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_department,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteDepartment" => %{"id" => id}}
      }

      assert expected_response == response
    end

    @tag :skip
    test "when id is invalid uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_department,
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
          "query" => @delete_department,
          "variables" => %{id: Ecto.UUID.generate()}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteDepartment" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "Department not found",
            "path" => ["deleteDepartment"]
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
          "query" => @delete_department
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
