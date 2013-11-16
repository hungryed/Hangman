class Hangman

  def initialize
    @mystery_words = []
    File.read('list_of_words.rb').each_line do |word|
      @mystery_words << word
    end
    @incorrect = 0
    @word = @mystery_words[rand(@mystery_words.length)]
    @length_of_word = @word.length
    @display_word = []
    @length_of_word.times do 
      @display_word << "_"
    end
    @guessed_letters = []
    display
  end

  def user_guessed_letter(letter, letter_index=0)
    if @word.include?(letter) == false
      @incorrect += 1
      @guessed_letters << letter
      display
    elsif @word.include?(letter) && @word.index(letter, letter_index) == nil
      @guessed_letters << letter
      display
    else     
      guessed_letter_index = @word.index(letter)
      @display_word[guessed_letter_index] = letter
      user_guessed_letter(letter, guessed_letter_index)
    end

  end

  def display
    if @incorrect >= 8
      puts "You failed. The word was #{@word}"
    elsif @display_word.join("") == @word
      puts "You win!!"
    else
      puts "Word: #{@display_word.join("")}"
      puts "You have #{8 - @incorrect} chances remaining"
      puts "Your previous guesses are " << @guessed_letters.join(",")
      print "Guess a letter: "
      user_guess = gets.chomp
      exit if user_guess == "exit"
      user_guessed_letter(user_guess)
    end
  end

  def play
    puts "Welcome to Hangman. Would you like to start a new game? (yes/no)"
    user_decision = gets.chomp
    if user_decision.include?("yes")
      initialize
    elsif user_decision.include?("no")
      exit
    else
      puts "Please type yes or no"
    end
  end 



end

player = Hangman.new
player.play