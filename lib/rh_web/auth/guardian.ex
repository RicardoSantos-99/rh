defmodule RhWeb.Auth.Guardian do
  use Guardian, otp_app: :delivery

  alias Rh.Error
  alias Rh.Schema.Employee

  def subject_for_token(%Employee{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Rh.get_employee(%{})
  end

  def authenticate(%{"id" => employee_id, "password" => password}) do
    with {:ok, %Employee{password_hash: hash} = user} <- Rh.get_employee(employee_id, %{}),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
