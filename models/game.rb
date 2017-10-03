require_relative "card"
require_relative "deck"
require_relative "hand"
require 'pry'
class Game
  attr_reader :player, :computer, :deck

  def initialize(gambler_name)
    @gambler_name = gambler_name
    @deck = Deck.new
    @play_again = true
    @games_won = 0
    @games_played = 0
  end

  def play
    while @play_again
      if @deck.cards.size < 10
        puts "Shuffling a new deck.\n"
        @deck = Deck.new
      end
      @games_played += 1
      @player = Hand.new(@deck.deal!(2), @gambler_name)
      @computer = Hand.new(@deck.deal!(2), "Dealer")
      @player.show_hand
      @computer.dealer_hand
      player_turn
      if @player.no_bust
        @computer.show_hand
        dealer_turn
        winners_circle
      end
      check_play_again
    end
  end

  def player_turn
    choice = ""
    while choice != "s" && @player.no_bust && @player.calculate_hand != 21 do
      puts "\nDo you want to hit or stand? (H/S)"
      choice = gets.chomp.downcase
      if choice == "h"
        puts "#{@gambler_name} hits."
        @player.hit(@deck)
        @player.check_bust
        check_perfect
      elsif choice == "s"
        puts "#{@gambler_name} stands.\n"
      else
        puts "Wrong key."
      end
    end
  end

  def check_perfect
    if @player.calculate_hand == 21
      puts "Blackjack!"
      choice = "s"
    end
  end

  def dealer_turn
    while @computer.calculate_hand <= 17 && @computer.no_bust
      @computer.hit(@deck)
      @computer.check_bust
    end
  end

  def winners_circle
    if @player.calculate_hand == @computer.calculate_hand
      puts "Push. No winner."
    elsif @player.calculate_hand > @computer.calculate_hand || !@computer.no_bust
      @games_won += 1
      puts "#{@gambler_name} wins!"
    else
      puts "Dealer wins."
    end
  end

  def scorecard
    puts "\nYou have won #{@games_won} out of #{@games_played} games."
  end

  def check_play_again
    response = ""
    scorecard
    while response != "y" && response != "n" do
      puts "Do you want to play again?"
      response = gets.chomp.downcase
      if response == "n"
        @play_again = false
        puts "Ok, see ya."
      elsif response == "y"
        @play_again = true
      else
        puts "Wrong key."
      end
    end
  end
end
