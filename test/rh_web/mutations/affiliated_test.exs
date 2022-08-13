defmodule RhWeb.Mutations.AffiliatedTest do
  @moduledoc false
  use RhWeb.ConnCase, async: true

  import Rh.Factory

  @create_affiliated """
    mutation createAffiliate($input: CreateAffiliateInput!) {
      createAffiliate(input: $input) {
        id
        name
      }
    }
  """

  @delete_affiliated """
    mutation deleteAffiliate($id: UUID4!) {
      deleteAffiliate(id: $id) {
        id
      }
    }
  """

  describe "create affiliate mutations" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, conn: conn, company: company}
    end

    @tag :skip
    test "when all params are valid, create a new affiliate", %{conn: conn, company: %{id: id}} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli",
                cnpj: "12341234123412",
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createAffiliate" => %{
                   "id" => _id,
                   "name" => "vli"
                 }
               }
             } = response
    end

    @tag :skip
    test "when affiliated name already exist, return an error", %{conn: conn, company: %{id: id}} do
      build(:affiliated, %{company_id: id}) |> Rh.create_affiliate(%{})

      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli",
                cnpj: "12341234123413",
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createAffiliate" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "name has already been taken",
                   "path" => ["createAffiliate"]
                 }
               ]
             } = response
    end

    @tag :skip
    test "when affiliated cnpj already exist, return an error", %{conn: conn, company: %{id: id}} do
      params = build(:affiliated, %{company_id: id})

      Rh.create_affiliate(params, %{})

      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli-1",
                cnpj: "12341234123412",
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createAffiliate" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "cnpj has already been taken",
                   "path" => ["createAffiliate"]
                 }
               ]
             } = response
    end

    @tag :skip
    test "when company id does not exist, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli",
                cnpj: "12341234123412",
                company_id: Ecto.UUID.generate()
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createAffiliate" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "Company not found",
                   "path" => ["createAffiliate"]
                 }
               ]
             } == response
    end

    @tag :skip
    test "when cnpj is invalid, returns an error", %{conn: conn, company: %{id: id}} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli",
                cnpj: "123",
                company_id: id
              }
            }
          }
        )
        |> json_response(:ok)

      assert %{
               "data" => %{"createAffiliate" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "cnpj should be 14 character(s)",
                   "path" => ["createAffiliate"]
                 }
               ]
             } == response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(
          "/api/graphql",
          %{
            "query" => @create_affiliated,
            "variables" => %{
              input: %{
                name: "vli",
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
                   "locations" => [%{"column" => 21, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"cnpj\": Expected type \"String!\", found null.\nIn field \"company_id\": Expected type \"UUID4!\", found \"id\".\nIn field \"teste\": Unknown field."
                 }
               ]
             } == response
    end
  end

  describe "delete affiliate mutations" do
    setup %{conn: conn} do
      company_params = build(:company)

      {:ok, company} = Rh.create_company(company_params)

      {:ok, affiliate} =
        build(:affiliated, %{company_id: company.id})
        |> Rh.create_affiliate(build(:employee))

      {:ok, conn: conn, affiliate: affiliate}
    end

    @tag :skip
    test "when id is valid, delete an affiliate", %{conn: conn, affiliate: %{id: affiliate_id}} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_affiliated,
          "variables" => %{id: affiliate_id}
        })
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"deleteAffiliate" => %{"id" => affiliate_id}}
      }

      assert expected_response == response
    end

    @tag :skip
    test "when id is invalid uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_affiliated,
          "variables" => %{id: "affiliate_id"}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 21, "line" => 2}],
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
          "query" => @delete_affiliated,
          "variables" => %{id: Ecto.UUID.generate()}
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "Affiliate not found",
            "path" => ["deleteAffiliate"]
          }
        ],
        "data" => %{"deleteAffiliate" => nil}
      }

      assert expected_response == response
    end

    @tag :skip
    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post("/api/graphql", %{
          "query" => @delete_affiliated
        })
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 21, "line" => 2}],
            "message" => "In argument \"id\": Expected type \"UUID4!\", found null."
          },
          %{
            "locations" => [%{"column" => 28, "line" => 1}],
            "message" => "Variable \"id\": Expected non-null, found null."
          }
        ]
      }

      assert expected_response == response
    end
  end
end
