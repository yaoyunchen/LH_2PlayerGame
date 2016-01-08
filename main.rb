require "./methods"
require "./variables"
require "colorize"

game_running = true
new_game = true
while game_running

  #See if the players would like to play.
  puts new_game ? "Would you like to play a game? (Y/N)" : "Would you like to play again? (Y/N)"
  prompt = gets.chomp.downcase

  case prompt
  when "y", "yes"
    #Game begins.  Not a new game any more.
    if new_game
      puts "What is player 1's name?"
      @player_one[:name] = gets.chomp
      puts "What is player 2's name?"
      @player_two[:name] = gets.chomp
      new_game = false
    end

    #Resets the game if it was previously played.
    game_reset if @game_over == true

    #Determine which player goes first.
    puts "Determining who's first...Heads for #{@player_one[:name]}, Tails for #{@player_two[:name]}."
    coin_flip
    if @player_turn == 1
      puts "Flipping a coin...#{coin_flip}! #{@player_one[:name]} goes first!"
    else
      puts "Flipping a coin...#{coin_flip}! #{@player_two[:name]} goes first!"
    end
    

    #Loop through the game until one player loses.
    while @game_over == false

      #Generate question for the player.
      puts @player_turn == 1 ? "\nQuestion for #{@player_one[:name]}..." : "\nQuestion for #{@player_two[:name]}..."
      generate_question
      puts "What does #{@question[:num_one]} #{@operator} #{@question[:num_two]} equal?"

      #Ask user for answer.
      @player_answer = get_num

      #Check if answer is correct.
      if verify_answer == true
        puts "Correct! \n#{@player_one[:name]}: #{@player_one[:score]} pts, #{@player_two[:name]}: #{@player_two[:score]} pts.".green
      else
        puts "WRONG! Answer is #{@question[:result]}.".red
        puts "#{@player_one[:name]}: #{@player_one[:score]} pts, #{@player_two[:name]}: #{@player_two[:score]} pts.".red

        #Checks if the player still has lives left.
        puts check_lives
      end
    end
    #Display player total wins.
    puts "#{@player_one[:name]}: #{@player_one[:wins]} wins, #{@player_two[:name]}: #{@player_two[:wins]} wins.".yellow
  when "n", "no", "quit"
    puts "Thanks for playing!"
    game_running = false
    exit
  else
    puts "I'm sorry, I didn't get that."
  end
end


