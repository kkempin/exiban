defmodule ExIban.EctoValidatorTest do
  use ExUnit.Case

  test "accepts valid IBAN" do
    changeset = %{changes: %{iban: "PT26003506518127614794482"}, errors: [], valid?: true}
    assert changeset == ExIban.EctoValidator.validate_iban(changeset, :iban)
    assert changeset.valid?
  end

  test "rejects IBAN with bad check digits" do
    changeset = %{changes: %{iban: "PT26003506518127614794481"}, errors: [], valid?: true}
    changeset = ExIban.EctoValidator.validate_iban(changeset, :iban)
    assert [iban: {"bad check digits", []}] == changeset.errors
    assert not changeset.valid?
  end

  test "rejects too short IBAN" do
    changeset = %{changes: %{iban: "0026"}, errors: [], valid?: true}
    changeset = ExIban.EctoValidator.validate_iban(changeset, :iban)

    assert [{:iban, {"too short", []}}] == changeset.errors
    assert not changeset.valid?
  end

  test "rejects IBAN with unknown country code" do
    changeset = %{changes: %{iban: "0026003506518127614794481"}, errors: [], valid?: true}
    changeset = ExIban.EctoValidator.validate_iban(changeset, :iban)

    assert [
             {:iban, {"unknown country code", []}},
             {:iban, {"bad length", []}},
             {:iban, {"bad check digits", []}}
           ] ==
             changeset.errors

    assert not changeset.valid?
  end

  test "rejects IBAN with bad chars" do
    changeset = %{changes: %{iban: "ptabcdefghijklmnopqrstu"}, errors: [], valid?: true}
    changeset = ExIban.EctoValidator.validate_iban(changeset, :iban)

    assert [
             {:iban, {"bad length", []}},
             {:iban, {"bad format", []}},
             {:iban, {"bad check digits", []}}
           ] ==
             changeset.errors

    assert not changeset.valid?
  end
end
