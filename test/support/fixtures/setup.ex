defmodule Support.Fixtures.Setup do
  alias Rh.Modules.Admin.Users, as: CreateUser
  alias Rh.Schema.User

  def add_user do
    {:ok, %User{password: password, email: email}} =
      CreateUser.call(%{
        email: "camundangas@teste.com",
        password: "123456789",
        name: "Camundangas"
      })

    {:ok, %{token: token}} = CreateUser.login(%{email: email, password: password})

    %{token: token}
  end
end
