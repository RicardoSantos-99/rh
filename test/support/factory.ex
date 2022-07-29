defmodule Rh.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Delivery.Repo

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
end
