defmodule Rh.Utils.Password do
  @moduledoc """
  Password utilities.
  """
  alias Ecto.Changeset

  @doc """
    Generate a password hash.
  """
  def put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    Changeset.change(changeset, Pbkdf2.add_hash(password))
  end

  def put_password_hash(changeset), do: changeset
end
