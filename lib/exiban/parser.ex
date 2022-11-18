defmodule ExIban.Parser do
  @moduledoc """
  Parse IBAN bank account as a string and prepare nice tuple.
  """

  @doc """
  Parse IBAN and return tuple
  {country_code, check_digits, bban, length of iban, normalized iban}

  ## Examples

      iex> ExIban.Parser.parse("  GB82 WEST 1234 5698 765432  ")
      {"GB", "82", "WEST12345698765432", 22, "GB82WEST12345698765432"}
  """

  @spec parse(binary) :: {bitstring, bitstring, bitstring, integer, bitstring}
  def parse(iban) when byte_size(iban) > 3 do
    iban = iban |> normalize

    {
      String.slice(iban, 0, 2),
      String.slice(iban, 2, 2),
      String.slice(iban, 4, String.length(iban) - 4),
      String.length(iban),
      iban
    }
  end

  def parse(_iban), do: {:error, :invalid_iban}

  defp normalize(iban) do
    iban
    |> String.replace(~r/\s+/, "")
    |> String.trim
    |> String.upcase
  end
end
