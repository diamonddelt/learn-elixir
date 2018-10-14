defmodule Cards do
    def create_deck do
        ["Ace", "Two", "Three"] # implicit return of a list
    end

    # shuffle/1 = a shuffle method with an "arity" of 1
    def shuffle(deck) do # arguments do not need a type
        Enum.shuffle(deck) # built-in shuffle method for an enumerable (list); seems to repeat on the 1st and 2nd invokation
    end
end
