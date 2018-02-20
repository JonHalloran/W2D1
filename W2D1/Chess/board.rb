require_relative "pieces/piece"
Dir["./pieces/*.rb"].each {|file| require file }

class Board
  attr_accessor :grid

  BOARD_SIZE = 8

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    create_pieces
  end

  def create_pieces
    self.grid[0][0] = Knight.new(:black, self, [0, 0])
    self.grid[-1][-1] = King.new(:white, self, [7, 7])
  end

  def empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def valid_move?(start_pos, end_pos)
    has_piece = !empty?(start_pos)
    empty_end = empty?(end_pos)
    has_piece && empty_end
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError unless valid_move?(start_pos, end_pos)
    self[start_pos], self[end_pos] = NullPiece.instance, self[start_pos]
  end

  def []=(pos, piece)
    row, col = pos
    self.grid[row][col] = piece
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def valid_pos?(pos)
    pos.all? { |i| in_range?(i) }
  end

  def in_range?(num)
    num.between?(0, BOARD_SIZE - 1)
  end

  def inspect
    self.to_s
  end

end
