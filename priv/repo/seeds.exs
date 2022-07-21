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

alias Rh.Schema.{Company, Affiliate, Employee, Occupation}

company = %{cnpj: "12312312312312", corporate_name: "RH", name: "ninha camundangas"}

{:ok, %Company{id: company_id}} = Rh.create_company(company)

develop = %{
  name: "Desenvolvedor",
  description: "Desenvolvedor de software",
  code: 1,
  company_id: company_id
}

qa = %{name: "QA", description: "Qualidade de software", code: 2, company_id: company_id}
suporte = %{name: "Suporte", description: "Suporte de software", code: 3, company_id: company_id}

Rh.create_occupation(develop)
Rh.create_occupation(qa)
{:ok, %Occupation{id: occupation_id}} = Rh.create_occupation(suporte)

affiliated = %{
  name: "vli",
  cnpj: "12341234123412",
  company_id: company_id
}

{:ok, %Affiliate{id: affiliate_id}} = Rh.create_affiliate(affiliated)

# %{
#   name: "Carlos Tinas",
#   email: "tinas@vale.com",
#   password: "12345678",
#   cpf: "16655512312",
#   employee: :ADMIN,
#   affiliate_id: "affiliate_id"
# }
