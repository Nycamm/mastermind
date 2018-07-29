class Game
  #creates new Code object and give instructions
  def initialize
    instructions

    @code = Code.new

    @code.guess
  end

  def instructions
    @instructions = ["\n",
                     "Welcome to Mastermind!",
                     "\n",
                     "Try to crack the secret code!",
                     "\n",
                     "Guess the pattern correctly and you win!",
                     "\n",
                     "There are four positions in the pattern. You must choose a colour for each position.",
                     "\n",
                     "If one of the colours you guessed is in the secret code I'll let you know!",
                     "\n",
                     "             - If the colour AND position are correct I will give you a 'Bull'.",
                     "             - If the colour is correct, but the position is wrong I will give you a 'Cow'.",
                     "             - You don't get anything if the colour isn't in the code at all, sorry!",
                     "             - Don't think it's going to be easy, I won't tell you WHICH position or colour was correct!",
                     "\n",
                     "There are six colours to choose from: Red, Green, Blue, Yellow, Orange and Pink.",
                     "\n",
                     "Type the first letter of the four colours you want to choose in order.",
                     "\n",
                     "For example, if you want to guess 'red, green, blue, yellow', enter 'rgby'.",
                     "\n",
                     "Duplicates are OK!",
                     "\n",
                     "Type 'quit' if you want to give up.",
                     "\n",
                     "Good luck!"]

    @instructions.each_with_index do |message, i|
      if i > 10 && i < 15
        puts message
      else
        puts message.center(100)
      end
    end
  end
end

class Code
  #creates a new secret code and initialize @attempts to zero
  def initialize
    @attempts = 0
    @colours = "rgbyop".split("")

    puts "\nPlease choose your Codemaster.\nIf you would like play against the computer enter 'c'.\nTo choose a secret code yourself and challenge a friend choose 'p'."

    new_code(gets.chomp.downcase)
  end

  #sets a random code
  def new_code(code_master)
    if code_master == "c"
      @secret_code = []
      4.times {@secret_code.push(@colours.sample)}
    elsif code_master == "p"
      puts "What's your four colour secret code?"
      @secret_code = gets.chomp.downcase.split("")

      if @secret_code.length != 4 || @secret_code.any? { |code| !@colours.include?(code) }
        puts "You can't choose that."
        new_code("p")
      end
    else
      puts "Please enter 'c' or 'p' to choose Computer or Player."
      new_code(gets.chomp.downcase)
    end
  end

  #prompts for guess, checks if win or lose, calls evaluate and incriments @attempts
  def guess
    puts "\nYou have #{(12 - @attempts).to_s} attempts left, what's your guess?"
    @guesses = Array(gets.chomp.downcase.split(""))

    if @guesses == @secret_code
      puts "\nYou win! Play again? (y/n)"
      play_again(gets.chomp.downcase)
    elsif @guesses == "quit".split("")
      play_again("n")
    elsif @attempts == 11
      puts "\nYou lose, too bad. The secret code was #{@secret_code.to_s} Play again? (y/n)"
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
        @misses[i] = "bull"
      end
    end

    @guesses.each do |guess|
      if @misses.include?(guess)
        @misses[@misses.index(guess)] = "cow"
      end
    end

    @misses.each do |hit|
      if hit == "bull"
        @bulls += 1
      elsif hit == "cow"
        @cows += 1
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
