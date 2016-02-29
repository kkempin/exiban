defmodule ExIban.EctoValidator do
  @moduledoc """
  Validator for Ecto
  """

  @doc """
  Validate Ecto changeset

  ## Examples

      defmodule User do
        use Ecto.Schema
        use Ecto.Model

        schema "users" do
          field :email, :string
          field :iban, :string
        end

        def changeset(user, params \\\\ :empty) do
          user
          |> cast(params, ~w(iban email), ~w())
          |> ExIban.EctoValidator.validate_iban(:iban)
        end
      end
  """

  @spec validate_iban(map, bitstring) :: map | {:error, map}
  def validate_iban(changeset, field) do
    %{changes: changes, errors: errors} = changeset

    iban = Map.get(changes, field)
    case ExIban.validate(iban) do
      {:error, new_errors} ->
        new_errors = new_errors
                      |> Enum.map(&Atom.to_string/1)
                      |> Enum.map(&(String.replace(&1, "_", " ")))
                      |> Enum.map(&({field, &1}))
        %{changeset | errors: new_errors ++ errors, valid?: false}
      :ok -> changeset
    end
  end
end
