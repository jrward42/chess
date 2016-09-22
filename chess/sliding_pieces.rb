require_relative 'piece.rb'

class SlidingPieces < Piece
  def initialize(color, board, pos)
    super
  end

  def up
    result = []
    x, y = @pos[0] + 1, @pos[1]

    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x += 1
    end
    result.nil? ? [] : result
  end

  def down
    result = []
    x, y = @pos[0] - 1, @pos[1]
    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x -= 1
    end
    result.nil? ? [] : result
  end

  def left
    result = []
    x, y = @pos[0], @pos[1] -1

    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      y -= 1
    end
    result.nil? ? [] : result
  end

  def right
    result = []
    x, y = @pos[0], @pos[1] + 1

    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      y += 1
    end
    result.nil? ? [] : result
  end

  def right_diag
    result = []

    x, y = @pos[0] + 1, @pos[1] - 1
    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x += 1
      y -= 1
    end

    x, y = @pos[0] - 1, @pos[1] + 1
    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x -= 1
      y += 1
    end

    result.nil? ? [] : result
  end

  def left_diag
    result = []

    x, y = @pos[0] + 1, @pos[1] + 1
    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x += 1
      y += 1
    end

    x, y = @pos[0] -1, @pos[1] -1
    while move_checker(x, y) || opponents_piece?(x, y)
      result << [x, y]
      break if opponents_piece?(x, y)
      x -= 1
      y -= 1
    end

    result.nil? ? [] : result
  end
end

class Rook < SlidingPieces

  def initialize(color, board, pos)
    super
    @display_value = (color == :white ? "♖" : "♜")
  end

  def move_dirs
    up + down + left + right
  end
end

class Bishop < SlidingPieces
  def initialize(color, board, pos)
    super
    @display_value = (color == :white ? "♗" : "♝")
  end

  def move_dirs
    right_diag + left_diag
  end
end

class Queen < SlidingPieces
  def initialize(color, board, pos)
    super
    @display_value = (color == :white ? "♕" : "♛")
  end

  def move_dirs
    up + down + left + right + right_diag + left_diag
  end
end

# board = Board.new
# queen = Queen.new(:white, board, [0, 0])
# queen2 = Queen.new(:black, board, [1, 0])
# board[[0, 0]] = queen
# board[[1, 0]] = queen2
# queen2.board = board
# p queen.moves
