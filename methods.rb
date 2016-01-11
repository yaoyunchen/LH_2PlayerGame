#Used to set up a new game.
def setup_new_game
  #Create player 1.
  @player1 = Player.new(1)
  get_name(@player1)  

  #Create player 2.
  @player2 = Player.new(2)
  get_name(@player2)

  #Game begins.  Not a new game any more.
  @new_game = false
end

#Get player names.
def get_name(player)
  puts "What is player #{player.player_number}'s name?"
  player.name = gets.chomp
  raise NoNameError, "No name." if player.name.empty?
rescue NoNameError
  puts "Please enter a name."
  retry
end

#Resets the game.
def game_reset
  @game_over = false
  @player1.reset
  @player2.reset
end


#Sets the current player.
def set_current_player(player)
  #Randomly determines current player first time the program runs.
  @current_player = 1 + rand(2) if @current_player == 0
  #Flips between player 1 and 2.
  @current_player == 1 ? @current_player = 2 : @current_player = 1
end


#Pretend the player order is determined by a coin flip.
def coin_flip
  ret_str = "Determining who's first...Heads for #{@player1.name}, Tails for #{@player2.name}\n"
  if @current_player == 1  
    ret_str << "Flipping a coin...Heads! #{@player1.name} goes first!" 
  else
    ret_str <<  "Flipping a coin...Tails! #{@player2.name} goes first!"
  end
   ret_str
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
    @current_player == 1 ? @player1.gain_point : @player2.gain_point

    return_str << "Correct! \n#{@player1.name}: #{@player1.score} pts, #{@player2.name}: #{@player2.score} pts.".green
  else
    #If the answer is incorrect.
    @current_player == 1 ? @player1.lose_life : @player2.lose_life
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
    @player2.gain_win
    "#{@player1.name} has no lives left.  #{@player1.name} has lost!".yellow
  elsif @player2.lives == 0
    @player1.gain_win
    "#{@player2.name} has no lives left.  #{@player2.name} has lost!".yellow
  else
    "#{@player1.name}: #{@player1.lives} lives, #{@player2.name}: #{@player2.lives} lives.".red
  end
end


#Determines if the game is over.
def check_if_game_over
  @player1.lives == 0 || @player2.lives == 0 ? true : false
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
    puts "Invalid entry.  Please enter a number."
    retry
  end 
  return num
end


#Gets the player answer.
def get_player_answer
  @player_answer = gets.chomp
  raise InvalidGuessError, "Invalid entry" unless is_number?(@player_answer) == true
end


#Checks if the entered string is a number and returns true if it is.
def is_number?(string)
  true if Float(string) rescue false
end


