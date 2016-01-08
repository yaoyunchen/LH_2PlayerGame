#Loads the player class.
require "./Player"
require "./variables"
require "./methods"
require "colorize"

while @game_running

  #See if the players would like to play.
  puts @new_game ? "Would you like to play a game? (Y/N)" : "Would you like to play again? (Y/N)"
  prompt = gets.chomp.downcase

  case prompt
    when "y", "yes"
      
      #Set up the  game if this is the first time.
      start_new_game if @new_game
     
      #Resets the game if it was previously played.
      game_reset if @game_over == true

      #Determine which player goes first.
      puts "Determining who's first...Heads for #{@player1.name}, Tails for #{@player2.name}"
      toss = coin_flip
      if @player_turn == 1
        puts "Flipping a coin...#{toss}! #{@player1.name} goes first!"
      else
        puts "Flipping a coin...#{toss}! #{@player2.name} goes first!"
      end

      #Loop through the game until one player loses.
      while @game_over == false

        #Generate question for the player.
        puts @player_turn == 1 ? "\nQuestion for #{@player1.name}..." : "\nQuestion for #{@player2.name}..."
        generate_question
        puts "What does #{@question[:num_one]} #{@operator} #{@question[:num_two]} equal?"

        #Ask user for answer.
        @player_answer = get_num

        #Check if answer is correct.
        if verify_answer == true
          puts "Correct! \n#{@player1.name}: #{@player1.score} pts, #{@player2.name}: #{@player2.score} pts.".green
        else
          puts "WRONG! Answer is #{@question[:result]}.".red
          puts "#{@player1.name}: #{@player1.score} pts, #{@player2.name}: #{@player2.score} pts.".red

          #Checks if the player still has lives left.
          puts check_lives
        end
      end
      #Display player total wins.
      puts "#{@player1.name}: #{@player1.wins} wins, #{@player2.name}: #{@player2.wins} wins.".yellow
    when "n", "no", "quit"
      puts "Thanks for playing!"
      @game_running = false
      exit
    else
      puts "I'm sorry, I didn't get that."
  end
end


