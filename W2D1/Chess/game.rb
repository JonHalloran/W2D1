require_relative "board"
require_relative "human_player"
require_relative "display"
require "byebug"

class ChessGame

  attr_reader :board, :players, :display
  attr_accessor :current_color

  def initialize
    @board = Board.new
    @display = Display.new(self.board)
    @players = { white: HumanPlayer.new(:white, self.display),
                 black: HumanPlayer.new(:black, self.display) }
    @current_color = :white
  end

  def play_game
    until game_over?
      try_move
      self.current_color = (self.current_color == :white ? :black : :white)
    end
  end

  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def current_player
    self.players[current_color]
  end

  def try_move
    begin
      # debugger
      start_pos, end_pos = current_player.make_move(board)
      board.move_piece(start_pos, end_pos, self.current_color)
    rescue InvalidMoveError
      retry
    end
  end


end

if $PROGRAM_NAME == __FILE__
  game = ChessGame.new
  game.play_game
end
