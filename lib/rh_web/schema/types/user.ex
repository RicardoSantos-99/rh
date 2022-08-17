defmodule RhWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:uuid4)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :name, non_null(:string)
  end
end
