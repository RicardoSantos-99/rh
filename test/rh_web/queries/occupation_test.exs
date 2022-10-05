defmodule RhWeb.Queries.OccupationTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @get_occupation_by_id """
    query getOccupation($id: UUID4!) {
      getOccupation(id: $id) {
        name
      }
    }
  """

  @list_occupations """
    query listOccupations {
      listOccupations {
        name
      }
    }
  """

  describe "occupations queries" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, occupation} =
        build(:occupation, %{company_id: company.id})
        |> Rh.create_occupation()

      {:ok, conn: conn, occupation: occupation}
    end

    @tag :skip
    test "find occupation by id, return occupation", %{conn: conn, occupation: %{id: id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @get_occupation_by_id,
          "variables" => %{id: id}
        })
        |> json_response(:ok)

      assert response == %{"data" => %{"getOccupation" => %{"name" => "QA"}}}
    end

    @tag :skip
    test "find all occupations, should return a list of occupation", %{
      conn: conn,
      occupation: %{name: name}
    } do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @list_occupations
        })
        |> json_response(:ok)

      assert response == %{"data" => %{"listOccupations" => [%{"name" => name}]}}
    end
  end
end
