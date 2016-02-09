# ExIban

Library for manipulating and validating IBAN account numbers.

## Installation

The package can be installed as:

  1. Add exiban to your list of dependencies in `mix.exs`:

        def deps do
          [{:exiban, "~> 0.0.1"}]
        end


  2. Run `mix deps.get` in your console to fetch from Hex


## Usage
    iex> ExIban.valid?("GB82 WEST 1234 5698 7654 32")
    true

    iex> ExIban.valid?("GB82 WEST 999 9999 9999")
    false

## Documentation
Hosted on [http://hexdocs.pm/exiban/ExIban.html](http://hexdocs.pm/exiban/ExIban.html)

## Author
Krzysztof Kempiński

ExIban is released under the [MIT License](https://github.com/appcues/exsentry/blob/master/LICENSE.txt).
