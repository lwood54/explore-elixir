defmodule Poker do
  @moduledoc """
    Provides methods for creating heads up matches of a poker hand.
  """

  @spec create_deck :: list
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["S", "C", "H", "D"]

    for suit <- suits, value <- values do
      "#{value}#{suit}"
    end
  end

  def extract_number(val) do
    case Integer.parse(val) do
      {num, ""} -> {:ok, num}
      {num, rest} -> {num, rest}
      :error -> Poker.get_points(val)
    end
  end

  def get_points(value) do
    [card_val, _rest] = String.split(value,"", trim: true)
    case card_val do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      _ -> "No match for points"
    end

  end

  def fresh_deck do
    Poker.create_deck
    |> Poker.shuffle_deck
  end

  def shuffle_deck(deck) do
    Enum.shuffle(deck)
  end

  def deal_hand(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def deal_flop(deck) do
    Poker.deal_hand(deck, 3)
  end

  def deal_one(deck) do
    Poker.deal_hand(deck, 1)
  end

  def get_winner(hand1, hand2) do
    false
  end

  def high_card?(list) do
    Enum.max(list)
    # return max num and remaining list
    # {
    #   max_val: Enum.max(list),
    #   rest: List.pop_at()
    # }
  end

  def find_max_five(hand, board) do
    combined = List.flatten([hand, board])
    max_list = [Poker.high_card?(combined)]
    max_list = [Poker.high_card?()]
    # recursively go through list getting max_val each time and rmv
  end

  def pair?(hand, board) do
    false
  end

  def two_pair?(hand, board) do
    false
  end

  def three_kind?(hand, board) do
    false
  end

  def straight?(hand, board) do
    false
  end

  def flush?(hand, board) do
    false
  end

  def full_house?(hand, board) do
    false
  end

  def four_kind?(hand, board) do
    false
  end

  def straight_flush?(hand, board) do
    false
  end

  def royal_flush?(hand, board) do
    false
  end

  def play_txh do
    deck = Poker.fresh_deck
    {hand1, deck} = Poker.deal_hand(deck, 2)
    {hand2, deck} = Poker.deal_hand(deck, 2)
    {the_flop, deck} = Poker.deal_hand(deck, 3)
    {_burn, deck} = Poker.deal_hand(deck, 1)
    {the_turn, deck} = Poker.deal_hand(deck, 1)
    {_burn, deck} = Poker.deal_hand(deck, 1)
    {the_river, _deck} = Poker.deal_hand(deck, 1)
    # winner = Poker.get_winner(hand1, hand2, the_flop, the_turn, the_river)
    [
      board: List.flatten([the_flop, the_turn, the_river]),
      hand1: hand1,
      hand2: hand2,
      winner: "FILLER..."
    ]
  end

end
