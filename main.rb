#Loads the player class.
require "./Player"
require "./variables"
require "./methods"
require "colorize"

while @program_running

  #See if the players would like to play.
  puts @new_game ? "Would you like to play a game? (Y/N)" : "Would you like to play again? (Y/N)"
  prompt = gets.chomp.downcase

  case prompt
    when "y", "yes"
      
      #Set up the  game if this is the first time.
      setup_new_game if @new_game
     
      #Resets the game.
      game_reset 

      #Determine which player goes first.
      set_current_player(0)
      #Pretend there's a coin flip to determine player order.
      puts coin_flip   

      #Loop through the game until one player loses.
      until check_if_game_over

        #Generate question for the player.
        puts @current_player == 1 ?  "\nQuestion for #{@player1.name}..." : "\nQuestion for #{@player2.name}..."
        puts generate_question 

        #Ask user for answer.
        @player_answer = get_num

        #Check if answer is correct.
        puts verify_answer

        #Check if the players still has lives left.
        check_if_game_over
      end

      #Display player total wins.
      puts "#{@player1.name}: #{@player1.wins} wins, #{@player2.name}: #{@player2.wins} wins.".yellow

    when "n", "no", "quit"

      puts "Thanks for playing!"
      @program_running = false
      exit

    else

      puts "I'm sorry, I didn't get that."

  end
end


