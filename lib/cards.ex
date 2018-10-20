defmodule Cards do
    def create_deck do
        # implicit return of a list
        values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
        suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

        # exploring a multiple list comprehension
        # similar to a for loop, iterating over two enumerables at once
        # Avoids a nested loop
        for suit <- suits, value <- values do
            "#{value} of #{suit}"
        end
    end

    # shuffle/1 = a shuffle method with an "arity" of 1
    def shuffle(deck) do # arguments do not need a type
        Enum.shuffle(deck) # built-in shuffle method for an enumerable (list); seems to repeat on the 1st and 2nd invokation
    end

    # Elixir convention - functions that return booleans have question marks
    # contains?/2 will take a deck of cards and a card as arguments, and indicates if the card is in the deck
    # Uses the member?/2 function from the Enum built-in module
    def contains?(deck, card) do
        Enum.member?(deck, card)
    end

    # use Enum.split/2 to return a tuple
    # 1) the modified deck with "number" of cards removed
    # 2) the cards removed from the deck, in another list
    # keeping immutability in mind, there is no modification to either of the arguments in this function
    def deal(deck, number) do
        Enum.split(deck, number)
    end

    # Writes a given deck to a file on the local filesystem
    # Uses native Erlang code to encode the data structure into a suitable format before saving
    # Returns an :ok or :error atom on success/failure
    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end

    # Loads a deck from the local filesystem
    # Uses native Erland code to decode the data structure and return it
    # The case statement both compares the File.read() result to one of the case lines,
    # as well as assigns the return value to the variable in the case line tuples if there is a match.
    # Then, the match line will return the result of the expression after the ->
    # Uses the "_variable" notation to ignore a result; similar to golang's _ operator
    # Uses case statement with atoms to handle IO read errors
    def load(filename) do
        case File.read(filename) do
            {:ok, deck} -> :erlang.binary_to_term(deck)
            {:error, _reason} -> "Invalid file name"
        end
    end
end
