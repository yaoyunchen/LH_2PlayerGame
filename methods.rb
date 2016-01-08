#Flips a coin to see who goes first.
def coin_flip
  @player_turn = 1 + rand(2) 
  @player_turn == 1 ? "Heads" : "Tails"
end


#Used to set up a new game.
def start_new_game
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


#Generate a question to ask a player.
def generate_question
  @question[:num_one] = 1 + rand(20)
  @question[:num_two] = 1 + rand(20)
  @operator = ['+', '-', '*'].sample
  @question[:result] = @question[:num_one].send(@operator, @question[:num_two])
end


#Checks if the player got the answer right.
def verify_answer
  if @player_answer.to_i == @question[:result].to_i
    #If the answer is correct.
    if @player_turn == 1 
      @player1.score += 1
      @player_turn = 2
    else
      @player2.score += 1
      @player_turn = 1
    end
    return true
  else
    #If the answer is incorrect.
    if @player_turn == 1
      @player1.lives -= 1
      @player_turn = 2
    else
      @player2.lives -= 1
      @player_turn = 1
    end 
    return false
  end
end


#Check how much life is left for players.
def check_lives
  if @player1.lives == 0
    @game_over = true
    @player2.wins += 1
    "#{@player1.name} has no lives left.  #{@player1.name} has lost!".yellow
  elsif @player2.lives == 0
    @game_over = true
    @player1.wins += 1
    "#{@player2.name} has no lives left.  #{@player2.name} has lost!".yellow
  else
    "#{@player1.name}: #{@player1.lives} lives, #{@player1.name}: #{@player2.lives} lives.".red
  end
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