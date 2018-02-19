require_relative "piece"

class Board
  attr_accessor :grid


  def initialize
    @grid = Array.new(8) { Array.new(8) }
    create_pieces
  end

  def create_pieces
    self.grid[0].map! { |_| Piece.new }
    self.grid[-1].map! { |_| Piece.new }
  end

  def empty?(pos)
    self[pos] == nil
  end

  def valid_move?(start_pos, end_pos)
    has_piece = !empty?(start_pos)
    empty_end = empty?(end_pos)
    has_piece && empty_end
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError unless valid_move?(start_pos, end_pos)
    self[start_pos], self[end_pos] = nil, self[start_pos]
  end

  def []=(pos, piece)
    row, col = pos
    self.grid[row][col] = piece
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

end
