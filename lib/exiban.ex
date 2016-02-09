defmodule ExIban do
  @moduledoc """
  Validate and manipulate IBAN account number.
  """

  import ExIban.Parser
  import ExIban.Validators

  @doc """
  Perform validation rules on IBAN.

  ## Examples

      iex> ExIban.validate("GB82 WEST 1234 5698 7654 32")
      :ok

      iex> ExIban.validate("GB82 WEST 999 9999 9999")
      { :error, [:bad_length, :bad_format, :bad_check_digits] }
  """

  @spec validate(bitstring) :: :ok | {:error, list}
  def validate(iban) do
    iban
    |> issues
    |> prepare_output
  end

  @doc """
  Checks if IBAN is valid.

  ## Examples

      iex> ExIban.valid?("GB82 WEST 1234 5698 7654 32")
      true

      iex> ExIban.valid?("GB82 WEST 999 9999 9999")
      false
  """

  @spec valid?(bitstring) :: true | false
  def valid?(iban) do
    iban
    |> issues
    |> do_valid?
  end

  @doc """
  Returns country code extracted from IBAN.

  ## Examples

      iex> ExIban.country_code("GB82 WEST 1234 5698 7654 32")
      "GB"
  """

  @spec country_code(bitstring) :: bitstring
  def country_code(iban) do
    {country_code, _, _, _, _} = parse(iban)
    country_code
  end

  @doc """
  Returns bban extracted from IBAN.

  ## Examples

      iex> ExIban.bban("GB82 WEST 1234 5698 7654 32")
      "82"
  """

  @spec bban(bitstring) :: bitstring
  def bban(iban) do
    {_, bban, _, _, _} = parse(iban)
    bban
  end

  @doc """
  Format and pretify IBAN to be more readable.

  ## Examples

      iex> ExIban.format(" GB 82     WEST 1234 5698765432  ")
      "GB82 WEST 1234 5698 7654 32"
  """

  @spec format(bitstring) :: bitstring
  def format(iban) do
    {_, _, _, _, formatted} = parse(iban)
    formatted
    |> String.replace(~r/(.{4})/, "\\1 ")
    |> String.strip
  end

  defp prepare_output({[], _}), do: :ok
  defp prepare_output({issues, _}) do
    {:error, issues}
  end

  defp do_valid?({[], _}), do: true
  defp do_valid?(_), do: false
end
