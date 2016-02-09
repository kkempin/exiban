defmodule ExIban.Rules do
  @moduledoc """
  Set of rules to check during validation.
  """

  @doc """
  Map of rules. Key represents country code.
  """

  @spec rules :: %{bitstring => %{bitstring => integer, bitstring => bitstring}}
  def rules do
    # https://github.com/iulianu/iban-tools/blob/master/lib/iban-tools/rules.yml
    %{"AD" => %{"length" => 24, "bban_pattern" => "\\d{8}[A-Z0-9]{12}"},
      "AE" => %{"length" => 23, "bban_pattern" => "\\d{19}"},
      "AL" => %{"length" => 28, "bban_pattern" => "\\d{8}[A-Z0-9]{16}"},
      "AT" => %{"length" => 20, "bban_pattern" => "\\d{16}"},
      "BA" => %{"length" => 20, "bban_pattern" => "\\d{16}"},
      "BE" => %{"length" => 16, "bban_pattern" => "\\d{12}"},
      "BG" => %{"length" => 22, "bban_pattern" => "[A-Z]{4}\\d{6}[A-Z0-9]{8}"},
      "BH" => %{"length" => 22, "bban_pattern" => "[A-Z]{4}[A-Z0-9]{14}"},
      "CH" => %{"length" => 21, "bban_pattern" => "\\d{5}[A-Z0-9]{12}"},
      "CY" => %{"length" => 28, "bban_pattern" => "\\d{8}[A-Z0-9]{16}"},
      "CZ" => %{"length" => 24, "bban_pattern" => "\\d{20}"},
      "DE" => %{"length" => 22, "bban_pattern" => "\\d{18}"},
      "DK" => %{"length" => 18, "bban_pattern" => "\\d{14}"},
      "DO" => %{"length" => 28, "bban_pattern" => "[A-Z]{4}\\d{20}"},
      "EE" => %{"length" => 20, "bban_pattern" => "\\d{16}"},
      "ES" => %{"length" => 24, "bban_pattern" => "\\d{20}"},
      "FI" => %{"length" => 18, "bban_pattern" => "\\d{14}"},
      "FO" => %{"length" => 18, "bban_pattern" => "\\d{14}"},
      "FR" => %{"length" => 27, "bban_pattern" => "\\d{10}[A-Z0-9]{11}\\d{2}"},
      "GB" => %{"length" => 22, "bban_pattern" => "[A-Z]{4}\\d{14}"},
      "GE" => %{"length" => 22, "bban_pattern" => "[A-Z]{2}\\d{16}"},
      "GI" => %{"length" => 23, "bban_pattern" => "[A-Z]{4}[A-Z0-9]{15}"},
      "GL" => %{"length" => 18, "bban_pattern" => "\\d{14}"},
      "GR" => %{"length" => 27, "bban_pattern" => "\\d{7}[A-Z0-9]{16}"},
      "HR" => %{"length" => 21, "bban_pattern" => "\\d{17}"},
      "HU" => %{"length" => 28, "bban_pattern" => "\\d{24}"},
      "IE" => %{"length" => 22, "bban_pattern" => "[A-Z]{4}\\d{14}"},
      "IL" => %{"length" => 23, "bban_pattern" => "\\d{19}"},
      "IS" => %{"length" => 26, "bban_pattern" => "\\d{22}"},
      "IT" => %{"length" => 27, "bban_pattern" => "[A-Z]\\d{10}[A-Z0-9]{12}"},
      "KW" => %{"length" => 30, "bban_pattern" => "[A-Z]{4}\\d{22}"},
      "KZ" => %{"length" => 20, "bban_pattern" => "[0-9]{3}[A-Z0-9]{13}"},
      "LB" => %{"length" => 28, "bban_pattern" => "\\d{4}[A-Z0-9]{20}"},
      "LI" => %{"length" => 21, "bban_pattern" => "\\d{5}[A-Z0-9]{12}"},
      "LT" => %{"length" => 20, "bban_pattern" => "\\d{16}"},
      "LU" => %{"length" => 20, "bban_pattern" => "\\d{3}[A-Z0-9]{13}"},
      "LV" => %{"length" => 21, "bban_pattern" => "[A-Z]{4}[A-Z0-9]{13}"},
      "MC" => %{"length" => 27, "bban_pattern" => "\\d{10}[A-Z0-9]{11}\\d{2}"},
      "ME" => %{"length" => 22, "bban_pattern" => "\\d{18}"},
      "MK" => %{"length" => 19, "bban_pattern" => "\\d{3}[A-Z0-9]{10}\\d{2}"},
      "MR" => %{"length" => 27, "bban_pattern" => "\\d{23}"},
      "MT" => %{"length" => 31, "bban_pattern" => "[A-Z]{4}\\d{5}[A-Z0-9]{18}"},
      "MU" => %{"length" => 30, "bban_pattern" => "[A-Z]{4}\\d{19}[A-Z]{3}"},
      "NL" => %{"length" => 18, "bban_pattern" => "[A-Z]{4}\\d{10}"},
      "NO" => %{"length" => 15, "bban_pattern" => "\\d{11}"},
      "PL" => %{"length" => 28, "bban_pattern" => "\\d{8}[A-Z0-9]{16}"},
      "PT" => %{"length" => 25, "bban_pattern" => "\\d{21}"},
      "RO" => %{"length" => 24, "bban_pattern" => "[A-Z]{4}[A-Z0-9]{16}"},
      "RS" => %{"length" => 22, "bban_pattern" => "\\d{18}"},
      "SA" => %{"length" => 24, "bban_pattern" => "\\d{2}[A-Z0-9]{18}"},
      "SE" => %{"length" => 24, "bban_pattern" => "\\d{20}"},
      "SI" => %{"length" => 19, "bban_pattern" => "\\d{15}"},
      "SK" => %{"length" => 24, "bban_pattern" => "\\d{20}"},
      "SM" => %{"length" => 27, "bban_pattern" => "[A-Z]\\d{10}[A-Z0-9]{12}"},
      "TN" => %{"length" => 24, "bban_pattern" => "\\d{20}"},
      "TR" => %{"length" => 26, "bban_pattern" => "\\d{5}[A-Z0-9]{17}"},
      "UA" => %{"length" => 29, "bban_pattern" => "\\d{25}"}}
  end
end
