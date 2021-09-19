class Player
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def guess
    puts "#{@name} - Choose a letter to add to the word:"
    print "Guess: "
    char = gets.chomp.downcase
    char
  end

  def alert_invalid_guess
    puts "Not a valid guess. Try again:"
  end
end