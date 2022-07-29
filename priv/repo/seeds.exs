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

alias Rh.Schema.{Company, Affiliate, Employee, Occupation, CostCenter, Department}

company = %{cnpj: "12312312312312", corporate_name: "RH", name: "ninho de camundangas"}

{:ok, %Company{id: company_id}} = Rh.create_company(company)

develop = %{
  name: "dev",
  description: "dev de software",
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

cost_center = %{
  name: "Engenharia",
  description: "Engenharia de software",
  code: "2",
  affiliate_id: affiliate_id
}

{:ok, %CostCenter{id: cost_center_id}} = Rh.create_cost_center(cost_center)

department = %{
  name: "Desenvolvimento",
  description: "Desenvolvimento de software",
  code: "1",
  cost_center_id: cost_center_id
}

{:ok, %Department{id: department_id}} = Rh.create_department(department)

%{
  name: "Carlos Tinas",
  email: "tinas@vale.com",
  password: "12345678",
  cpf: "16655512312",
  employee: :ADMIN,
  affiliate_id: "affiliate_id"
}
