#Used to set up a new game.
def setup_new_game
 #Create player 1.
  puts "What is player 1's name?"
  @player1 = Player.new(gets.chomp)

  #Create player 2.
  puts "What is player 2's name?"
  @player2 = Player.new(gets.chomp)

  #Game begins.  Not a new game any more.
  @new_game = false
end


#Resets the game.
def game_reset
  @game_over = false
  @player1.lives = 3
  @player1.score = 0
  @player2.lives = 3
  @player2.score = 0
end


#Sets the current player.
def set_current_player(player)
  #Randomly determines current player first time the program runs.
  @current_player = 1 + rand(2) if @current_player == 0
  #Flips between player 1 and 2.
  @current_player == 1 ? @current_player = 2 : @current_player = 1
end


#Generate a question to ask a player.
def generate_question
  @question[:num_one] = 1 + rand(20)
  @question[:num_two] = 1 + rand(20)
  operator = ['+', '-', '*'].sample
  @question[:result] = @question[:num_one].send(operator, @question[:num_two])
  "What does #{@question[:num_one]} #{operator} #{@question[:num_two]} equal?"
end


#Checks if the player got the answer right.
def verify_answer
  #Builds string to return.
  return_str = ""

  if @player_answer.to_i == @question[:result].to_i
    #If the answer is correct.
    @current_player == 1 ? @player1.score += 1 : @player2.score += 1

    return_str << "Correct! \n#{@player1.name}: #{@player1.score} pts, #{@player2.name}: #{@player2.score} pts.".green
  else
    #If the answer is incorrect.
    @current_player == 1 ? @player1.lives -= 1 : @player2.lives -= 1

    return_str << "WRONG! Answer is #{@question[:result]}.\n".red + check_lives
  end

  #Change the player.
  set_current_player(@current_player)
  
  #Return the built string.
  return_str
end


#Check how much life is left for players.
def check_lives
  if @player1.lives == 0
    @player2.wins += 1
    "#{@player1.name} has no lives left.  #{@player1.name} has lost!".yellow
  elsif @player2.lives == 0
    @player1.wins += 1
    "#{@player2.name} has no lives left.  #{@player2.name} has lost!".yellow
  else
    "#{@player1.name}: #{@player1.lives} lives, #{@player2.name}: #{@player2.lives} lives.".red
  end
end


#Determines if the game is over.
def check_if_game_over
  @player1.lives == 0 || @player2.lives == 0 ? true : false
end


#Pretend the player order is determined by a coin flip.
def coin_flip
  ret_str = "Determining who's first...Heads for #{@player1.name}, Tails for #{@player2.name}\n"
  ret_str << @current_player == 1 ? "Flipping a coin...Heads! #{@player1.name} goes first!" : "Flipping a coin...Tails! #{@player2.name} goes first!"
end


#Only allow numeric entries.
def get_num
  is_num = false
  begin
    while is_num == false
      num = Float(gets.chomp)
      is_num = true
    end
  rescue ArgumentError
    puts :"Invalid entry.  Please enter a number."
    retry
  end 
  return num
end




