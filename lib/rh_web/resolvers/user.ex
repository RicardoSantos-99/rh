defmodule RhWeb.Resolvers.User do
  def login(params, _context), do: Rh.user_login(params)

  # def logout(_params, %{context: %{current_user: current_user}}), do: Rh.logout(current_user)

  # def logout(_params, _context), do: {:error, "not logged in"}
end
