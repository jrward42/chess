require 'singleton'
class NullPiece
  attr_reader :display_value
  attr_accessor :pos
  include Singleton

  def initialize
    @display_value = "X"
    @pos = nil
  end

  def moves
    []
  end

  def color
  end

  def empty?
  end
end
