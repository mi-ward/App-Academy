class AI_Player
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def assess(fragment, player_count)
    dictionary = {}
    pc = player_count 
    

    File.foreach("dictionary.txt") do |line| 
        word = line.chomp.to_s
        wfdiff = word.length - fragment.length 

        if word[0...fragment.length].include?(fragment) && wfdiff > 1 && wfdiff <= pc
          dictionary[word] = 0
        end
      end
      p dictionary
    end
end

#modulo for collecting all options that can be played and still win
#ability to find and guess a letter
#enter bug