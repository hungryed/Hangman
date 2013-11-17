class Hangman

  def initialize
    @mystery_words = []
    File.read('list_of_words.rb').each_line do |word|
      @mystery_words << word
    end
    @incorrect = 0
    @word = @mystery_words.sample
    @length_of_word = @word.length
    @display_word = []
    @length_of_word.times do 
      @display_word << "_"
    end
    @guessed_letters = []
    display
  end

  def user_guessed_letter(letter, letter_index=0)
    if @guessed_letters.include?(letter)
      puts "You already guessed that letter"
    elsif letter.length > 1
      if letter == @word
        @display_word = letter.split("")
      else
        @incorrect = 8
      end
    elsif @word.include?(letter) && @word.index(letter, letter_index) != nil
        guessed_letter_index = @word.index(letter, letter_index)
        @display_word[guessed_letter_index] = letter
        guessed_letter_index += 1
        user_guessed_letter(letter, guessed_letter_index)
    elsif @word.include?(letter) == false
      @incorrect += 1
    end
    @guessed_letters << letter
    display_human
    game_over?
    display

  end

  def game_over?
    if @incorrect >= 8
      puts "You failed. The word was #{@word}"
      play_again?
    elsif @display_word.join("") == @word
      puts "You win!!"
      play_again?
    end
  end

  def display
    puts "Word: #{@display_word.join("")}"
    puts "You have #{8 - @incorrect} chances remaining"
    puts "Your previous guesses are " << @guessed_letters.join(",")
    print "Guess a letter: "
    user_guess = gets.chomp
    exit if user_guess == "exit"
    user_guessed_letter(user_guess)
  end

  def play_again?
    puts "Would you like to play again? (yes/no)"
    user_decision = gets.chomp
    if user_decision.include?("yes")
      initialize
    elsif user_decision.include?("no")
      exit
    else
      puts "exiting..."
      exit
    end
  end


  def play
    puts "Welcome to Hangman. Would you like to start a new game? (yes/no)"
    if user_decision.include?("yes")
      initialize
    elsif user_decision.include?("no")
      exit
    else
      puts "Please type yes or no"
    end
  end 

  def display_human
    left_eye = @incorrect >= 7
    right_eye = @incorrect >= 8
    head = @incorrect >= 1
    torso = @incorrect >= 2
    left_arm = @incorrect >= 3
    right_arm = @incorrect >= 4
    left_leg = @incorrect >= 5
    right_leg = @incorrect >= 6

    puts "    -----"
    puts "    |   |"
    puts "    | #{head ? "|" : " "}#{left_eye ? "x" : " "}#{head ? "_" : " "}#{right_eye ? "x" : " "}#{head ? "|" : " "}"
    puts "    |#{left_arm ? " --" : "   "}#{torso ? "|" : " "}#{right_arm ? "--" : " "}"
    puts "    |   #{torso ? "|" : ""}"
    puts "    | #{left_leg  ? " /": ""} #{right_leg ? '\ ': ""}"
    puts "    | "
    puts " -----------"
  end




end

player = Hangman.new
player.play