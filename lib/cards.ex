defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @spec create_deck :: list
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @spec shuffle(any) :: list
  @doc """
    Returns a shuffled array of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @spec contains?(any, any) :: boolean
  @doc """
    Returns boolean of whether card is found in provided deck.
  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Hearts")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @spec deal(any, integer) :: {list, list}
  @doc """
    Returns a hand and remaining cards from a provided deck and defined hand size.
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @spec save(
          any,
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: :ok | {:error, atom}
  @doc """
    Saves provided deck to a specified file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: any
  @doc """
    Loads saved deck or provides message if file doesn't exist.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary } -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  @spec create_hand(integer) :: {list, list}
  @doc """
    Returns a hand of specified size by combining create_deck, shuffle, and deal of hand size.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
