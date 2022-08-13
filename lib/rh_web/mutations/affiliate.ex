defmodule RhWeb.Mutations.Affiliate do
  @moduledoc """
  affiliate mutations.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Affiliate, as: AffiliateResolver

  alias Crudry.Middlewares.TranslateErrors

  object :affiliate_mutation do
    field :create_affiliate, type: :affiliate do
      arg :input, non_null(:create_affiliate_input)

      resolve &AffiliateResolver.create/3
      middleware TranslateErrors
    end

    field :delete_affiliate, type: :affiliate do
      arg :id, non_null(:uuid4)

      resolve &AffiliateResolver.delete/3
      middleware TranslateErrors
    end
  end
end
