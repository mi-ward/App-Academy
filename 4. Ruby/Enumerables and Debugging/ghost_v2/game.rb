require_relative "./player.rb"

# creates new Game class with multiplayer
# creates a blank fragment
# imports dictionary
# creates losses counter
class Game
  def initialize(*players)
    @players = players.map {|player| Player.new(player)}
    @fragment = ""
    @dictionary = {}
    File.foreach("dictionary.txt") {|line| @dictionary[line.chomp.to_s] = 0}
    @losses = Hash.new(0)
    @players.each {|player| @losses[player] = 0}
    @turn = 0
  end

  #retrieves current player 
  def current_player
    @players[0]
  end

  #retrieves list of rounds lost
  def losses
    @losses
  end

  #retrieves person who just added to the fragment
  #if no turns have taken place will return nil 
  def previous_player
    if @turn == 0
        nil
    else
        @players[-1]
    end
  end

  #rotates previous player to the end of the array
  def next_player!
    @players.rotate!
  end

  #lists current word fragment
  #takes in a guess from each player and identifies if it's valid
  #if it isn't valid it continues to ask until a valid letter is identified
  #if it is valid it adds the letter to the fragment, updates the turn, and changes to the next turn
  def take_turn(player)
    display_fragment
    temp = @fragment + player.guess
    puts

    while !valid_play?(temp)
        display_fragment
        player.alert_invalid_guess
        temp = @fragment + player.guess
        puts
    end

    @fragment = temp
    @turn += 1
    next_player!
    
  end

  #runs through dictionary to see fragment is part of any word
  def valid_play?(string)
    @dictionary.each do |k,v|
        if k[0..@fragment.length].include?(string)
            return true
        end
    end

    return false
  end

  #resets the fragment
  #asks current player to take a turn
  #when turn ends, adds a loss to player who completed a word
  def play_round
    puts "\nNEW ROUND"
    @fragment = ""
    while !@dictionary.include?(@fragment)
      take_turn(current_player)
    end
    @losses[previous_player] += 1
    display_losses
  end

  #runs the game
  #if rounds for a player equals 5, remove them from the game
  #if all other players are removed, declare a winner
  def run
    game_over = false

    while !game_over
      @losses.each do |player, rounds|
        if rounds == 5 && @players.include?(player)
            puts "#{player.name} is out."
            @players.pop
              if @players.length == 1
                puts "#{current_player.name} is the winner!" 
                return
              end      
        end
      end
      play_round
    end
  end

  def display_losses
    puts "ROUND OVER"
    puts "------"
    puts "Word: #{@fragment}"
    puts "------"
    puts "SCOREBOARD"
    @losses.each do |player, loss_count|
      ghost = "GHOST"
      if loss_count == 0
        puts "#{player.name}: "
      else
        puts "#{player.name}: ".ljust(10) + "#{ghost[0..loss_count-1]}"
      end
    end
    puts "------"
  end

  def display_fragment
    puts "-------------"
    puts "Current word: #{@fragment}"
    puts "-------------"
  end
end




game = Game.new("Michael", "Lauren","Ari")
game.run
