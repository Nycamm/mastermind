class Game
  #creates new Code object and give instructions
  def initialize
    @code = Code.new

    puts "Welcome to Mastermind!"
    puts "\nTry to crack the secret code!"
    puts "Guess the pattern correctly and you win!"
    puts "\nThere are four positions in the pattern. You must choose a colour for each position."
    puts "\nIf one of the colours you guessed is in the secret code I'll let you know!"
    puts " - If the colour AND position are correct I will give you a 'Bull'."
    puts " - If the colour is correct, but the position is wrong I will give you a 'Cow'."
    puts " - You don't get anything if the colour isn't in the code at all, sorry!"
    puts " - Don't think it's going to be easy, I won't tell you WHICH position or colour was correct!"
    puts "\nThere are six colours to choose from: red, green, blue, yellow, orange and pink."
    puts "\nType the first letter of the four colours you want to choose in order."
    puts "\nFor example, if you want to guess 'red, green, blue, yellow', enter 'rgby'."
    puts "\nDuplicates are OK!"
    puts "\nType 'quit' if you want to give up."
    puts "\nGood luck!"

    @code.guess
  end
end

class Code
  #creates a new secret code and initialize @attempts to zero
  def initialize
    @attempts = 0
    @colours = "rgbyop".split("")
    new_code
  end

  #sets a random code
  def new_code
    @secret_code = []
    4.times {@secret_code.push(@colours.sample)}
  end

  #prompts for guess, checks if win or lose, calls evaluate and incriments @attempts
  def guess
    puts "\nYou have #{(12 - @attempts).to_s} attempts left, what's your guess?"
    @guesses = Array(gets.chomp.downcase.split(""))

    if @guesses == @secret_code
      puts "\nYou win! Play again? (y/n)"
      play_again(gets.chomp.downcase)
    elsif @guesses = "quit".split("")
      play_again("n")
    elsif @attempts == 12
      puts "\nYou lose, too bad. Play again? (y/n)"
      play_again(gets.chomp.downcase)
    else
      #check that guess is formated correctly
      if @guesses.length != 4 || @guesses.any? { |guess| !@colours.include?(guess) }
        puts "\nYou can't guess that, try again please."

        guess
      else
        @attempts += 1

        evaluate

        guess
      end
    end
  end

  #For each perfect match put "bull" and each colour match put "cow"
  def evaluate
    @misses = @secret_code[0..-1]
    @bulls = 0
    @cows = 0

    @guesses.each_with_index do |guess, i|
      if @secret_code[i] == guess
        @bulls += 1
        @misses.slice!(@misses.index(guess))
      end
    end

    @guesses.each do |guess|
      if @misses.include?(guess)
        @cows += 1
        @misses.slice!(@misses.index(guess))
      end
    end

    puts "\nYou guessed #{@guesses.to_s} and got #{@bulls.to_s} Bulls and #{@cows.to_s} Cows."
  end

  def play_again(answer)
    if answer == "y"
      Game.new
    elsif answer != "n"
      puts "Please enter 'y' for yes or 'n' for no. Would you like to play again? (y/n)"
      play_again(gets.chomp.downcase)
    end
  end
end

Game.new
