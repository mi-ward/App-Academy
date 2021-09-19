class AI_Player
  
  attr_reader :name
  

  def initialize(name)
    @name = name
  end

  #gets every possible next option of a word and builds a dictionary
  def assess(fragment)
    dictionary = {}
    
    File.foreach("dictionary.txt") do |line| 
        word = line.chomp.to_s
        wfdiff = word.length - fragment.length 

        if word[0...fragment.length].include?(fragment)
          dictionary[word] = wfdiff
        end
    end
      dictionary
  end


  def ai_guess(fragment, player_count)
    possible_words = assess(fragment)
    losing_letters = []
    winning_letters = []
    guess = ""

    
    possible_words.each do |word, diff|
      if diff % player_count == 1 && !losing_letters.include?(word[diff * -1])
        losing_letters << word[diff * -1]
      elsif !losing_letters.include?(word[diff * -1]) && !winning_letters.include?(word[diff * -1])
        winning_letters << word[diff * -1]
      end
    end

    if winning_letters.empty?
      guess = losing_letters.sample
    else
      guess = winning_letters.sample
    end

    puts "#{@name} - Choose a letter to add to the word:"
    print "Guess: #{guess}"
    puts
    guess


  end
end


#ability choose whether the player is computer or human
#enter bug