require_relative 'piece.rb'

class SteppingPieces < Piece
  def initialize(color, board, pos)
    super
  end
end

class King < SteppingPieces
  def initialize(color, board, pos)
    super
    @display_value = (color == :white ? "♔" : "♚")
  end

  def move_dirs
    result = []
    x, y = @pos
    (-1..1).each do |x1|
      (-1..1).each do |y1|
        if opponents_piece?(x + x1, y + y1)
          result << [x + x1, y + y1]
        elsif (x1 == 0 && y1 == 0 ) || !move_checker(x + x1, y + y1)
          next
        else
          result << [x + x1, y + y1]
        end
      end
    end
    result
  end
end

class Knight < SteppingPieces
  def initialize(color, board, pos)
    super
    @display_value = (color == :white ? "♘" : "♞")
  end

  def move_dirs
    result = []
    x, y = @pos
    (-2..2).each do |x1|
      next if x1 == 0
      (-2..2).each do |y1|
        if  opponents_piece?(x + x1, y + y1)
          result << [x + x1, y + y1]
        elsif  y1 == 0 || x1.abs == y1.abs || !move_checker(x + x1, y + y1)
          next
        else
          result << [x + x1, y + y1]
        end
      end
    end

    result
  end
end
#
# board = Board.new
# knight = Knight.new(:white, board, [0, 0])
# king = King.new(:black, board, [1, 2])
# board[[0, 0]] = knight
# board[[1, 2]] = king

# p knight.moves
# p king.moves
