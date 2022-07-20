# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rh.Repo.insert!(%Rh.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# alias Rh.{Company, Affiliate, Employee}

# rh = %{cnpj: "12312312312312", corporate_name: "RH", name: "ninha camundangas"}

# # {:ok, %Company{id: company_id}} = Company.changeset(rh)

# vli = %{
#   name: "vli",
#   cnpj: "12341234123412",
#   company_id: company_id
# }

# # {:ok, %Affiliate{id: affiliate_id}} = Company.changeset(vli)

# %{
#   name: "Carlos Tinas",
#   email: "tinas@vale.com",
#   password: "12345678",
#   cpf: "16655512312",
#   employee: :ADMIN,
#   affiliate_id: affiliate_id
# }
