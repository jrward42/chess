require 'byebug'
class Piece
  attr_accessor :pos, :color, :board, :display_value

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @display_value = ""
  end

  def moves
    move_dirs
  end

  def valid_moves
    result = []
    moves.each do |move|
      result << move unless move_into_check?(move)
    end
    result
  end

  def move_into_check?(new_pos)
    #debugger
    old_board = @board.board
    old_position = @pos
    @board.board = deep_dup(@board)

    @board.update_position(self, new_pos)

    check = @board.in_check?(@color)
    #debugger
    @board.board = old_board #revers back to old board
    @pos = old_position
    #p check
    check
  end

  def deep_dup(board)
    result = []
    board.board.each do |row|
      temp = []
      row.each {|piece| temp << piece}
      result << temp
    end
    result
  end

  def valid_moves?(pos)
    x, y = pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end

  def move_checker(x, y) #add color checker for pieces
    valid_moves?([x, y]) &&
    @board[[x, y]].is_a?(NullPiece)
  end

  def opponents_piece?(x, y)
    valid_moves?([x, y]) &&
    self.color != @board[[x, y]].color &&
    !@board[[x, y]].is_a?(NullPiece)
  end
end
