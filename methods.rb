#Flips a coin to see who goes first.
def coin_flip
  @player_turn = 1 + rand(2) 
  @player_turn == 1 ? "Heads" : "Tails"
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
      @player_one[:score] += 1
      @player_turn = 2
    else
      @player_two[:score] += 1
      @player_turn = 1
    end
    return true
  else
    #If the answer is incorrect.
    if @player_turn == 1
      @player_one[:lives] -= 1
      @player_turn = 2
    else
      @player_two[:lives] -= 1
      @player_turn = 1
    end 
    return false
  end
end

#Check how much life is left for players.
def check_lives
  if @player_one[:lives] == 0
    @game_over = true
    @player_two[:wins] += 1
    "#{@player_one[:name]} has no lives left.  #{@player_one[:name]} has lost!".yellow
  elsif @player_two[:lives] == 0
    @game_over = true
    @player_one[:wins] += 1
    "#{@player_two[:name]} has no lives left.  #{@player_two[:name]} has lost!".yellow
  else
    "#{@player_one[:name]}: #{@player_one[:lives]} lives, #{@player_two[:name]}: #{@player_two[:lives]} lives.".red
  end
end

#Resets the game
def game_reset
  @game_over = false
  @player_one[:lives] = 3
  @player_one[:score] = 0
  @player_two[:lives] = 3
  @player_two[:score] = 0
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