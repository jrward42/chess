require_relative 'piece.rb'

class Board
  attr_reader :board
  def initialize
    @board = Array.new(8) {Array.new(8) {"x"}}
  end

  def move(start, end_pos)
    if valid_move?(start, end_pos)
      @board[start], @board[end_pos] = @board[end_pos], @board[start]
    end
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @board[x][y] = piece
  end

  def valid_move?(start, end_pos)
    @board[end_pos]is_a?(NullPiece) && !@board[start]is_a?(NullPiece)
  end
end

board = Board.new
p board[[4, 4]]
