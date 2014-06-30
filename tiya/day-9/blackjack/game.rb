require 'io/console'
require 'colorize'
require 'pry'

class Card
  attr_accessor :name, :suit

  def initialize name, suit
    @name = name
    @suit = suit
  end

  def value
    {"J" => 10, "Q"=>10, "K"=>10, "A"=>11}.fetch(@name, @name)
    # case
    # when %W(J Q K).include?(@name) then value = 10
    # #when (@name == "J") || ("Q") || ("K") then value = 10
    # when @name == "A" then value = 11
    when value = @name
    end
    value
  end

  def display
    [@name, @suit].join("")
  end
end

class Deck

  def initialize
    @cards = []
  end

  def deck
    name = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
    suit = ["♤","♧","♡","♢"]
    new_deck = name.product(suit).shuffle
    new_deck.each {|card| @cards << Card.new(card[0], card[1])}
  end

  def hit(who)
    card = @cards.shift
    who.hand << card
  end
end

class Player
  attr_accessor :who, :hand, :value

  def initialize who
    @hand = []
    @who = who
    @score = 0
  end

  def score
    @hand.map(&:value).inject(:+)
  end

  def top_status
    hand.map(&:display).join("   ║║")
  end

  def bottom_status
    hand.map(&:display).join("║║   ")
  end

  def status
    hand.map(&:display).join(", ")
  end

  def hidden_card
    puts "#{self.who} showing only first card:"
    puts "#{hand.first.display}, ??"
  end

  def show_hand
    puts "#{self.who} hand is: "
    puts status
  end
end

class Game

  attr_accessor :dealer, :player, :cards

  def initialize cards, dealer, player
    @messages = []
    @cards = cards
    @dealer = dealer
    @player = player
  end

  def run_game
      title
      print_messages
      deal
      dealer.hidden_card
      player.show_hand
      dealer.score
      player.score
      @player_can_hit = true
      players_turn
      dealers_turn
      dealer.show_hand
      player.show_hand
      move = STDIN.getch
      apply_move(move)
  end

  def title
    system "clear" or system "cls"
    puts "-----------------------"
    title = "Blackjack".colorize(color: :blue)
    puts "-------" + title.blink + "-------"
    puts "-----------------------"
    puts " Press C for Controls"
    puts "***********************".colorize(color: :green)
  end

  def controls
    system "clear" or system "cls"
    puts "During game press and of the following:"
    puts "Press H to HIT or S to STAY."
    puts "Press R to view Rules."
    puts "Press Q to Quit."
    move = STDIN.getch
    controls_move(move)
  end

  def print_messages
    @messages.each do |message|
      puts "#{message}"
    end
    @messages = []
  end

  def controls_move move

    case move.downcase
    when 'r' then rules
    when 'n' then run_game
    when 'q' then exit
    else
      puts "Sorry, that is not an option. New Game or Quit?"
    end
  end

  def apply_move move

    case move.downcase
    when 'r' then rules
    when 'c' then controls
    when 'q' then exit
    else
      @messages << "Sorry, that is not an option."
    end
  end

  def hit?
    case STDIN.getch.downcase
    when "h"
      return true
    when "s"
      return false
    end
  end

  def rules
    system "clear" or system "cls"
    puts "*****************************"
    puts "------------RULES------------"
    puts "Each card holds a value between 2 and 11. Kings, Queens and Jacks are each worth"
    puts "10. An Ace is worth 11. The goal of the game is to get 21 or as close to 21 without"
    puts "going over."
    puts "Both the player and the dealer are dealt 2 cards. You must decide whether to HIT or"
    puts "STAY. Choosing HIT will add another card to you hand. Choosing STAY will keep you"
    puts "at your present total ending your turn. At which point it is the dealer's turn. Once"
    puts "the dealer's turn is over a winner will be decided based on who has the highest value"
    puts "hand. If at any point the dealer or the player hand goes over 21 the other wins."
    puts "First one to 21 wins! Good Luck!"
    move = STDIN.getch
    controls_move(move)
  end

  def win
    puts "You win!"
  end

  def lose
    puts "Dealer wins!"
  end

  def hands
    dealer.hand = []
    player.hand = []
  end

  def deal
    2.times do
      self.cards.hit(dealer)
      self.cards.hit(player)
    end
  end

  def player_has_not_busted?
    @player_can_hit and player.score < 21
  end

  def dealers_turn
    puts "Dealers turn"
    while dealer.score < 16
      self.cards.hit(dealer)
    end
  end

  def players_turn
    puts "Hit of Stay?!"
    while player_has_not_busted?
      if hit?
        self.cards.hit(player)
        player.show_hand
      else
        @player_can_hit = false
      end
    end
  end
end

dealer = Player.new("Dealer")
player = Player.new("Player")
cards = Deck.new
cards.deck
game = Game.new(cards, dealer, player)
game.run_game
