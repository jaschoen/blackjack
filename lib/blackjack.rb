class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end
# ================================================
class Player_hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def count
    count = 0
    cards.each do |card|
      count += card.value
    end
    count
  end
end
# ================================================
class Dealer_hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def count
    count = 0
    cards.each do |card|
      count += card.value
    end
    count
  end
end
# ================================================
class Console
  def welcome
    puts "Welcome to Blackjack, good luck!"
  end

  def prompt_for_action
    puts "Press 1 for hit and 2 for stay"
  end

  def dealer_showing(hand)
    puts "Dealer is showing the "
    puts hand.cards[0].name.to_s + " of " + hand.cards[0].suite.to_s 
    puts ""
  end
  def player_showing(hand)
    puts "Player cards are:"
    hand.cards.each do |card|
      puts card.name.to_s + " of " + card.suite.to_s 
    end
    puts ""
  end
  def you_lose
    puts "Dealer wins this one, maybe you're better at slot machines."
    exit
  end
  def you_win
    puts "You win! Well played."
    exit
  end
end
# ================================================
class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => 11}

  def initialize
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
    @playable_cards.shuffle!
  end

end
# ================================================

class Game
  attr_accessor :player_hand, :dealer_hand, :deck, :ui

  def initialize
    @player_hand = Player_hand.new
    @dealer_hand = Dealer_hand.new
    @deck        = Deck.new
    @ui          = Console.new
  end
  

  def start_game
    deal
    ui.welcome
    ui.dealer_showing(dealer_hand)
    ui.player_showing(player_hand)

    ui.prompt_for_action
    
    action = gets.chomp.to_i
    while action != 2
      hit_player
      ui.player_showing(player_hand)
      ui.you_lose if bust?(player_hand)
      action = gets.chomp.to_i 
    end


  end



  def deal
    2.times do 
    player_hand.cards << deck.playable_cards.pop
    dealer_hand.cards << deck.playable_cards.pop
    end
  end

  def hit_player
    player_hand.cards << deck.playable_cards.pop
  end

  def hit_dealer
    dealer_hand.cards << deck.playable_cards.pop
  end

  def bust?(hand)
    count = 0
    hand.cards.each do |card|
      count += card.value
    end
    count > 21 ? true : false
  end

  def blackjack?(hand)
    count = 0
    hand.cards.each do |card|
      count += card.value
    end
    count == 21 ? true : false
  end

end
# Game.new.start_game



