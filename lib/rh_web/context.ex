defmodule RhWeb.Context do
  @behaviour Plug

  import Ecto.Query, only: [where: 2]
  import Plug.Conn

  alias Rh.Repo
  alias Rh.Schema.{Employee, User}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    case check_token(token) do
      nil -> {:error, "invalid authorization token"}
      user -> {:ok, user}
    end
  end

  defp check_token(token) do
    with %Employee{} = employee <- find_employee(token) do
      employee
    else
      nil ->
        with %User{} = user <- find_user(token) do
          user
        else
          nil -> nil
        end
    end
  end

  defp find_user(token) do
    User
    |> where(token: ^token)
    |> Repo.one()
  end

  defp find_employee(token) do
    Employee
    |> where(token: ^token)
    |> Repo.one()
  end
end
