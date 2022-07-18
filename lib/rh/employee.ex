defmodule Rh.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.{Enum, Changeset}
  alias Rh.Affiliate

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @employees_type [:VALIDATOR, :RECRUIT, :MANAGER, :ADMIN]
  @required_params [:email, :password, :name, :cpf, :employee, :affiliate_id]

  schema "employees" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :cpf, :string
    field :employee, Enum, values: @employees_type

    belongs_to :affiliate, Affiliate

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
