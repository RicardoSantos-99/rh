defmodule Rh.Users.Create do
  use TODO
  alias Rh.Repo
  alias Rh.Schema.{Affiliate, Company, Employee, Occupation, User}
  alias RhWeb.Auth.Guardian

  @todo "0.0.1": "remove ecto to repository"
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  def login(%{email: email, password: password}) do
    with {:ok, user} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user),
         {:ok, _} <- store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def login_with_email_pass(email, password) do
    %User{password_hash: hash} = user = Repo.get_by(User, email: String.downcase(email))

    case Pbkdf2.verify_pass(password, hash) do
      true -> {:ok, user}
      false -> {:error, "Please verify your credentials"}
    end
  end

  def store_token(%User{} = user, token) do
    Ecto.Changeset.change(user, %{token: token})
    |> Repo.update()
  end

  @todo "0.0.1": "check if affiliate belongs to company"
  def employee(params, %User{}) do
    params
    |> Employee.changeset()
    |> Repo.insert()
  end

  @todo "0.0.1": "check if affiliate belongs to company"
  def affiliate(params, %User{}) do
    params
    |> Affiliate.changeset()
    |> Repo.insert()
  end

  def company(params, %User{}) do
    params
    |> Company.changeset()
    |> Repo.insert()
  end

  def occupation(params, %Occupation{}) do
    params
    |> Occupation.changeset()
    |> Repo.insert()
  end
end
