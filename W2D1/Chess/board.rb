require_relative "pieces/piece"
Dir["./pieces/*.rb"].each {|file| require file }
require "byebug"

class Board
  attr_accessor :grid

  BOARD_SIZE = 8
  HOME_ROW = { white: 7, black: 0 }.freeze

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    create_pieces
  end

  def create_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    back_row.map.with_index do |cls, i|
      self[[7, i]] = cls.new(:white, self, [7, i])
      self[[0, 7 - i]] = cls.new(:black, self, [0, 7 - i])
    end

    8.times do |i|
      self[[1, i]] = Pawn.new(:black, self, [1, i])
      self[[6, i]] = Pawn.new(:white, self, [6, i])
    end
  end

  def duplicate
    test_board = Board.new
    self.grid.each_index do |r_idx|
      self.grid[r_idx].each_index do |c_idx|
        test_board[[r_idx, c_idx]] = self[[r_idx, c_idx]].make_copy(test_board)
      end
    end
    test_board
  end

  def in_check?(color)
    king_pos = find_king_pos(color)
    flattened = self.grid.flatten
    other_pieces = flattened.reject { |piece| piece.color == color }
    other_pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def checkmate?(color)
    return false unless in_check?(color)
    flattened = self.grid.flatten
    my_pieces = flattened.select { |piece| piece.color == color }
    my_pieces.any? { |piece| !piece.valid_moves.empty? }
  end

  def empty?(pos)
    self.valid_pos?(pos) && self[pos].is_a?(NullPiece)
  end

  def valid_move?(start_pos, end_pos)
    return false if empty?(start_pos)
    piece = self[start_pos]
    piece.valid_moves.include?(end_pos)
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError unless valid_move?(start_pos, end_pos)
    self.commit_move(start_pos, end_pos)
  end

  def commit_move(start_pos, end_pos)
    self[start_pos].pos = end_pos
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

  private

  def find_king_pos(color)
    flattened = self.grid.flatten
    flattened.find do |piece|
      piece.color == color && piece.is_a?(King)
    end.pos
  end


end
