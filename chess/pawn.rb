require_relative 'piece.rb'
class Pawn < Piece
  def initialize(color, board, pos, moved = false)
    super(color, board, pos)
    @moved = moved
    @display_value = (color == :white ? "♙" : "♟")
  end

  def moves
    if @moved
      [up] + diagnols
    else
      first_move + diagnols
    end
  end

  def diagnols
    x, y = @pos
    diag_left = (color == :white ? [[x + 1, y - 1]] : [[x - 1, y - 1]])
    diag_right = (color == :white ? [[x + 1, y + 1]] : [[x - 1, y + 1]])
    result = diag_left + diag_right
    result.select {|move| opponents_piece?(move[0], move[1])}
  end

  def up
    pos = nil
    if color == :white
      pos = [@pos[0] + 1, @pos[1]]
    else
      pos = [@pos[0] - 1 , @pos[1]]
    end

    move_checker(pos[0], pos[1]) ? pos : []
  end

  def first_move
    up_two = nil

    if color == :white
      up_two = [@pos[0] + 2, @pos[1]]
    else
      up_two = [@pos[0] - 2, @pos[1]]
    end

    first_up = (move_checker(up_two[0], up_two[1]) ?  up_two : [])
    @moved = true
    [first_up, up].select {|n| !n.empty?}
  end
end

# board = Board.new
# pawn = Pawn.new(:black, board, [0, 0])
# pawn2 = Pawn.new(:white, board, [1, 0])
# board[[0, 0]] = pawn
# board[[1, 1]] = pawn2
# pawn.board = board
# p pawn.moves
