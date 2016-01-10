class Player
  attr_accessor :name, :lives, :score, :wins, :current

  def initialize(name)
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