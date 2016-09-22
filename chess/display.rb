require 'colorize'
require_relative 'board'
require_relative 'cursor'
require 'byebug'

class Display

  def initialize(board)
    @cursor_pos = Cursor.new([0,0], board)
    @board = board
  end

  def render
    str = "   "
    8.times {|n| str += " #{n.to_s.green}  "}
    puts str
    puts "   " + ("-" * 32)
    @board.board.each.with_index do |row, i|
      str = "#{i.to_s.green} |"
      row.each.with_index do |col, j|
        if @cursor_pos.cursor_pos == [i, j]
          str += " #{col.display_value.red} |"
        else
          str += " #{col.display_value} |"
        end
      end
      puts str
      puts "   " + ("-" * 32)
    end
  end

  def get_move
    move = nil
    until move != nil
      move = @cursor_pos.get_input
      system("clear")
      render
    end
    move
  end
end
