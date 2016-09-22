class Player
  attr_reader :name, :color
  def initialize(name, color)
    @name = name
    @color = color
  end
  #
  # def parse_move(move)
  #   move.scan(/[0-9]/).map(&:to_i)
  # end
end
