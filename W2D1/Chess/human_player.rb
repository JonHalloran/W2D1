require_relative "display"
require "byebug"

class HumanPlayer

  attr_reader :display

  def initialize(color, display)
    @color = color
    @display = display
  end


  def make_move(_)
    loop do
      # debugger
      self.display.render
      move = self.display.cursor.get_input
      return move if move
    end
  end


end
