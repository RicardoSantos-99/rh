defmodule RhWeb.Mutations.Occupation do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Occupation, as: OccupationResolver

  alias Crudry.Middlewares.TranslateErrors

  object :occupation_mutation do
    field :create_occupation, type: :occupation do
      arg :input, non_null(:create_occupation_input)

      resolve &OccupationResolver.create/2
      middleware TranslateErrors
    end

    field :delete_occupation, type: :occupation do
      arg :id, non_null(:uuid4)

      resolve &OccupationResolver.delete/2
      middleware TranslateErrors
    end
  end
end
