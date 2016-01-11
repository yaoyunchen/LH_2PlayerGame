class Player
  attr_accessor :name
  attr_reader :lives, :score, :wins, :player_number
  def initialize(player_number)
    @player_number = player_number
    @name = name
    @lives = 3
    @score = 0
    @wins = 0
  end

  def gain_point
  	@score += 1
  end

  def gain_win
  	@wins += 1
  end

  def lose_life
  	@lives -= 1
  end

  def reset
  	@lives = 3
  	@score = 0
  end
end