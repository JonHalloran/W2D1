
class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves
    []
  end

  def to_s
    " "
  end

  private

  def enemy?(other)
    other.color == (self.color == :white ? :black : :white)
  end

end
