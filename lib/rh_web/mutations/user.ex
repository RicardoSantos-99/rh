defmodule RhWeb.Mutations.User do
  @moduledoc """
  employee mutations.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.User, as: UserResolver

  alias Crudry.Middlewares.TranslateErrors

  object :user_mutation do
    field :user_login, type: :token do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve &UserResolver.login/2
      middleware TranslateErrors
    end

    field :user_create_employee, type: :employee do
      arg :input, non_null(:user_create_employee)

      resolve &UserResolver.user_create_employee/3
      middleware TranslateErrors
    end

    field :user_create_affiliate, type: :employee do
      arg :input, non_null(:user_create_affiliate)

      resolve &UserResolver.user_create_affiliate/3
      middleware TranslateErrors
    end
  end
end
