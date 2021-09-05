require_relative "./player.rb"

class Game
  def initialize(player1, player2)
    @players = [Player.new(player1), Player.new(player2)]
    @fragment = ""
    @dictionary = {}
    File.foreach("dictionary.txt") {|line| @dictionary[line.chomp.to_s] = 0}
    @losses = Hash.new(0)
    @turn = 0
  end

  def current_player
    @players[0]
  end

  def losses
    @losses
  end

  def previous_player
    if @turn == 0
        nil
    else
        @players[1]
    end
  end

  def next_player!
    @players.rotate!
  end

  def take_turn(player)
    puts "Current word: #{@fragment}"
    temp = @fragment + player.guess

    while !valid_play?(temp)
        puts "Current word: #{@fragment}"
        player.alert_invalid_guess
        temp = @fragment + player.guess
    end

    @fragment = temp
    @turn += 1
    next_player!
  end

  def valid_play?(string)
    @dictionary.each do |k,v|
        if k[0..@fragment.length].include?(string)
            return true
        end
    end

    return false
  end

  def play_round
    @fragment = ""
    while !@dictionary.include?(@fragment)
      take_turn(current_player)
    end
    @losses[previous_player] += 1
  end

  def run
    game_over = false

    while !game_over
      @losses.each do |player, rounds|
        if rounds == 5
            game_over = true
            puts "#{player.name} loses."
            return
        end
      end
      play_round
    end
  end

end




game = Game.new("Jim", "Pam")
game.run
