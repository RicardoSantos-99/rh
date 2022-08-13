defmodule Rh.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Delivery.Repo

  def employee_factory do
    %{
      name: "CAMUNDANGAS",
      email: "camundagas@vli.com",
      password: "12345678",
      cpf: "12312312312",
      employee: :RECRUIT,
      affiliate_id: "90b31bc7-0706-4faf-adb9-568f08595202",
      company_id: "a2590e5b-5ac0-47a5-ba01-d63582538f90",
      token: "token"
    }
  end

  def company_params_factory do
    %{cnpj: "12312312312312", corporate_name: "RH", name: "ninho de camundangas"}
  end

  def company_factory do
    %{
      cnpj: "12312312312312",
      corporate_name: "RH",
      name: "ninho de camundangas"
    }
  end

  def affiliated_factory do
    %{
      name: "vli",
      cnpj: "12341234123412",
      company_id: Ecto.UUID.generate()
    }
  end

  def occupation_factory do
    %{
      name: "QA",
      description: "Qualidade de software",
      code: 2,
      company_id: Ecto.UUID.generate()
    }
  end

  def cost_center_factory do
    %{
      name: "Engenharia",
      description: "Engenharia de software",
      code: "2",
      affiliate_id: Ecto.UUID.generate()
    }
  end

  def department_factory do
    %{
      name: "Desenvolvimento",
      description: "Desenvolvimento de software",
      code: "1",
      cost_center_id: Ecto.UUID.generate()
    }
  end
end
