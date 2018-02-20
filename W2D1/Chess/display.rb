require "colorize"
require_relative "board"
require_relative "cursor"

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system("clear")
    board.grid.each_index do |rindx|
      board.grid[rindx].each_index do |cindx|
        disp_pos([rindx, cindx])
      end
      puts ""
    end
    nil
  end

  def disp_pos(pos)
    piece = board[pos]
    background_color = pos.reduce(:+).odd? ? :light_black : :light_white
    if pos == self.cursor.cursor_pos
      background_color = :green
    end
    print piece.to_s.colorize(:background => background_color)
  end
  def inspect
    to_s
  end
end

if $PROGRAM_NAME == __FILE__
  disp = Display.new(Board.new)
  loop do
    disp.render
    disp.cursor.get_input
  end

end
