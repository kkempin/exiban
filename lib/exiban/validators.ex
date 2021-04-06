defmodule ExIban.Validators do
  @moduledoc """
  Set of validation rules to perform on checking IBAN account number.
  """

  import ExIban.Rules
  import ExIban.Parser

  @doc """
  Performs validation checks:
  - length greater or equal to 5 (:too_short)
  - only ilegal chars used [A-Z0-9] (bad_chars)
  - known country code (:unknown_country_code)
  - correct length for given country (:bad_length)
  - correct bban format for given country (:bad_format)
  - checking digits (:bad_check_digits)

  ## Examples

      iex> ExIban.Validators.issues("GB82")
      {[:too_short], nil}

      iex> ExIban.Validators.issues("GB_+)*")
      {[:bad_chars, :bad_length, :bad_format, :bad_check_digits], {"GB", "_+", ")*", 6, "GB_+)*"}}

      iex> ExIban.Validators.issues("GB82 WEST 1234 5698 7654 32")
      {[], {"GB", "82", "WEST12345698765432", 22, "GB82WEST12345698765432"}}
  """

  @spec issues(binary) :: {list, {bitstring, bitstring, bitstring, integer, bitstring} | nil}
  def issues(iban) when byte_size(iban) < 5, do: {[:too_short], nil}
  def issues(iban) do
    iban
    |> parse
    |> do_validation
  end

  defp do_validation(iban) do
    iban
    |> check_chars
    |> check_country_code
    |> check_length
    |> check_format
    |> check_digits
  end

  defp check_chars({_, _, _, _, iban} = parsed_iban) do
    cond do
      not Regex.match?(~r/^[A-Z0-9]+$/, iban) -> {[:bad_chars], parsed_iban}
      true                                    -> {[], parsed_iban}
    end
  end

  defp check_country_code({errors, {country_code, _, _, _, _} = parsed_iban}) do
    cond do
      rules |> Map.get(country_code) |> is_nil ->
        {errors ++ [:unknown_country_code], parsed_iban}
      true -> {errors, parsed_iban}
    end
  end

  defp check_length({errors,
    {country_code, _, _, iban_length, _} = parsed_iban}) do
    cond do
      rules |> Map.get(country_code, %{}) |> Map.get("length") != iban_length ->
        {errors ++ [:bad_length], parsed_iban}
      true -> {errors, parsed_iban}
    end
  end

  defp check_format({errors,
    {country_code, _, bban, _, _} = parsed_iban}) do
    {:ok, reg} = rules
                  |> Map.get(country_code, %{})
                  |> Map.get("bban_pattern", "")
                  |> Regex.compile
    cond do
      not Regex.match?(reg, bban) -> {errors ++ [:bad_format], parsed_iban}
      true                        -> {errors, parsed_iban}
    end
  end

  defp check_digits({errors,
    {country_code, check_digits, bban, _, _} = parsed_iban}) do
    chars = String.to_charlist(bban <> country_code <> check_digits)
    numbers = for byte <- chars, into: [] do
      case byte do
        byte when byte in 48..57 -> List.to_string([byte])
        byte when byte in 65..90 -> Integer.to_string(byte - 55)
        _ -> ""
      end
    end

    cond do
      numbers |> Enum.join |> String.to_integer |> rem(97) != 1 ->
        {errors ++ [:bad_check_digits], parsed_iban}
      true -> {errors, parsed_iban}
    end
  end
end
