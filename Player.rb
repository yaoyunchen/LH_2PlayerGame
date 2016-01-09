class Player
  attr_accessor :name, :lives, :score, :wins, :current

  def initialize(name)
    @name = name
    @lives = 3
    @score = 0
    @wins = 0
  end
end