defmodule RhWeb.Queries.Occupation do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Occupation, as: OccupationResolver

  object :occupation_queries do
    field :get_occupation, type: :occupation do
      arg :id, non_null(:uuid4)

      resolve &OccupationResolver.get/2
    end

    field :list_occupations, list_of(:occupation) do
      resolve &OccupationResolver.list/2
    end
  end
end
