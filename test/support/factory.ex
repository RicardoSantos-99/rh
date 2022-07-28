defmodule Delivery.Factory do
  use ExMachina.Ecto, repo: Delivery.Repo

  alias Rh.Schema.Company

  def company_params_factory do
    %{cnpj: "12312312312312", corporate_name: "RH", name: "ninho de camundangas"}
  end

  def user_factory do
    %Company{
      cnpj: "12312312312312",
      corporate_name: "RH",
      name: "ninho de camundangas"
    }
  end
end
