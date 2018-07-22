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
    puts "\nDuplicates are OK!"

    play
  end

  #prompts for and evaluates the player's guess
  def play
    @code.guess

    case @code.evaluate
    when "win"
      puts "You win! Would you like to play again? (y/n)"
      gets.chomp.downcase == "y" ? Game.new : return
    when "loose"
      puts "You lost, too bad. Would you like to play again? (y/n)"
      gets.chomp.downcase == "y" ? Game.new : return
    else
      puts @code.evaluate

      play
    end
  end
end

class Code
  #creates a new secret code and initialize @attempts to zero
  def initialize
    new_code
    @attempts = 0
  end

  #sets a random code
  def new_code
    @secret_code = Array("rgby".split(""))
  end

  #prompts for guess and incriments @attempts
  def guess
    puts "You have #{(12 - @attempts).to_s} attempts left, what's your guess?"
    @guess = Array(gets.chomp.downcase.split(""))
    @attempts += 1
  end

  #Compares guess to secret_code. If it matches, puts "win"
  #else when @attempts == 12 puts "loose", else for each perfect match put "bull"
  #and each colour match put "cow"
  def evaluate
    if @guess == @secret_code
      "win"
    elsif @attempts == 12
      "loose"
    else
      #compare @guess and @secret_code for cows and bulls
    end
  end
end

Game.new
