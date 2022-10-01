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

# alias Rh.Schema.{Company, Affiliate, Employee, Occupation, CostCenter, Department}

# user = %{
#   email: "camundagas@gmail.com",
#   password: "123456789",
#   name: "Camunda Gas"
# }

# if Application.get_env(:rh, :env) ==
#      "uCx4idbEyU4kgMypH0ezMpHefEZJBqpHd6/yBXQ3omS2P25s7pdR+Vqk+Y5UUJMr" do
#   Rh.Users.Create.call(user)
# end

# company = %{cnpj: "12312312312315", corporate_name: "RH", name: "ninho de camundangas"}

# {:ok, %Company{id: company_id}} = Rh.create_company(company)

# develop = %{
#   name: "dev",
#   description: "dev de software",
#   code: 1,
#   company_id: "company_id"
# }

# qa = %{name: "QA", description: "Qualidade de software", code: 2, company_id: "company_id"}

# suporte = %{
#   name: "Suporte",
#   description: "Suporte de software",
#   code: 3,
#   company_id: "company_id"
# }

# Rh.create_occupation(develop)
# Rh.create_occupation(qa)
# {:ok, %Occupation{id: _occupation_id}} = Rh.create_occupation(suporte)

# _affiliated = %{
#   name: "vli",
#   cnpj: "12341234123412",
#   company_id: "company_id"
# }

# {:ok, %Affiliate{id: affiliate_id}} = Rh.create_affiliate(affiliated)

# _cost_center = %{
#   name: "Engenharia",
#   description: "Engenharia de software",
#   code: "2",
#   affiliate_id: "affiliate_id"
# }

# {:ok, %CostCenter{id: cost_center_id}} = Rh.create_cost_center(cost_center)

# _department = %{
#   name: "Desenvolvimento",
#   description: "Desenvolvimento de software",
#   code: "1",
#   cost_center_id: "cost_center_id"
# }

# {:ok, %Department{id: department_id}} = Rh.create_department(department)

# %{
#   name: "CAMUNDANGAS",
#   email: "camundagas@vli.com",
#   password: "12345678",
#   cpf: "12312312312",
#   employee: :RECRUIT,
#   affiliate_id: "90b31bc7-0706-4faf-adb9-568f08595202",
#   company_id: "a2590e5b-5ac0-47a5-ba01-d63582538f90"
# }
