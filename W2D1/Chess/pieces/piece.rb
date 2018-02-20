require "byebug"
class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def make_copy(other_board)
    self.class.new(self.color, other_board, pos.dup)
  end

  def moves
    []
  end

  def valid_moves
    self.moves.reject { |pos| move_into_check?(pos) }
  end

  def to_s
    " "
  end

  private

  def move_into_check?(end_pos)
    test_board = board.duplicate
    test_board.commit_move(self.pos, end_pos)
    test_board.in_check?(self.color)
  end

  def enemy?(other)
    other.color == (self.color == :white ? :black : :white)
  end

  def ally?(other)
    other.color == (self.color == :black ? :black : :white)
  end

end
