require_relative 'null_piece.rb'
require_relative 'sliding_pieces.rb'
require_relative 'stepping_pieces.rb'
require_relative 'pawn.rb'
class Board
  attr_accessor :board
  def initialize
    null_piece = NullPiece.instance
    @board = Array.new(8) {Array.new(8) {null_piece}}
  end

  # def move(start, end_pos)
  #   if valid_move?(start, end_pos)
  #     @board[start], @board[end_pos] = @board[end_pos], @board[start]
  #   end
  # end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @board[x][y] = piece
  end

  def valid_move?(start, end_pos)
    piece = @board[start[0]][start[1]]
    return true if piece.valid_moves.include?(end_pos)
    false
  end

  def in_check?(color)
    king_position = get_position(King, color)

    @board.each.with_index do |row, i|
      row.each.with_index do |piece|
        if piece.color != color
          return true if piece.moves.include?(king_position)
        end
      end
    end
    false
  end

  def get_position(piece, color)
    @board.each.with_index do |row, i|
      @board.each.with_index do |col, j|
        return [i, j] if @board[i][j].is_a?(piece) && @board[i][j].color == color
      end
    end
    nil
  end

  def checkmate?(color)
    pos = get_position(King, color)
    king = @board[pos[0]][pos[1]]
    king_moves = king.moves

    king_moves.each do |move|
      x, y = move
      old_piece, @board[x][y] = @board[x][y], king
      check = in_check?(color)

      @board[x][y] = old_piece #reverting back to old piece
      return true if check
    end
    false
  end

  def update_position(piece, end_pos)
    x, y = piece.pos
    @board[x][y] = NullPiece.instance

    @board[end_pos[0]][end_pos[1]] = piece
    piece.pos = end_pos
  end

  def populate
    front_row
    back_row
  end

  def front_row
    [1, 6].each do |row|
      (0..7).each do |col|
        color = (row == 1 ? :white : :black)
        @board[row][col] = Pawn.new(color, self, [row, col])
      end
    end
  end

  def back_row
    [0, 7].each do |row|
      (0..7).each do |col|
        color = (row == 0 ? :white : :black)
        case col
        when 0
          @board[row][col] = Rook.new(color, self, [row, col])
        when 1
          @board[row][col] = Knight.new(color, self, [row, col])
        when 2
          @board[row][col] = Bishop.new(color, self, [row, col])
        when 3
          @board[row][col] = Queen.new(color, self, [row, col])
        when 4
          @board[row][col] = King.new(color, self, [row, col])
        when 5
          @board[row][col] = Bishop.new(color, self, [row, col])
        when 6
          @board[row][col] = Knight.new(color, self, [row, col])
        when 7
          @board[row][col] = Rook.new(color, self, [row, col])
        end
      end
    end
  end

end
#
# board = Board.new
# queen = Queen.new(:white, board, [2, 0])
# king = King.new(:white, board, [0, 0])
# rook = Rook.new(:black, board, [0, 7])
# #bishop = Bishop.new(:black, board, [2, 2])
# bishop = Bishop.new(:black, board, [2,2])
#
# board.update_position(queen, [2, 0])
# board.update_position(king, [0, 0])
# board.update_position(bishop, [2,2])
# #board.update_position(bishop, [2, 2])
# board.update_position(rook, [0, 7])
#
# #p queen.move_into_check?([1,0])
#
#
# # p board.in_check?(:white)

# board.update_position(queen,[1,0])
# p board.in_check?(:white)
# p board.checkmate?(:white)
