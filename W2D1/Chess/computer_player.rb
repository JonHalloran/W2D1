Dir["./pieces/*.rb"].each { |file| require file }
require_relative "board"
require "byebug"

class ComputerPlayer
  SEARCH_DEPTH = 2

  PIECE_VALUES = {
    NullPiece => 0,
    Pawn => 1,
    Bishop => 3,
    Knight => 3,
    Rook => 5,
    Queen => 9,
    King => 0
  }.freeze

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def make_move(board)
    _, move = minimax(board, SEARCH_DEPTH, self.color)
    move
  end

  def other_color(color)
    color == :white ? :black : :white
  end

  def minimax(board, depth, color)
    opponent_color = other_color(color)

    return [evaluate(board, color), nil] if depth == 0
    if board.checkmate?(color)
      return -[Float::INFINITY, nil]
    elsif board.checkmate?(opponent_color)
      return [Float::INFINITY, nil]
    end

    max_value = -Float::INFINITY
    max_move = nil
    next_boards(board, color).each do |new_board, move|
      value = minimax(new_board, depth - 1, opponent_color)[0] * -1
      if value >= max_value
        max_value = value
        max_move = move
      end
    end
    [max_value, max_move]
  end

  def next_boards(board, color)
    all_pieces = board.grid.flatten.select { |piece| piece.color == color }
    all_moves = all_pieces.reduce([]) do |acc, piece|
      acc + piece.valid_moves.map {|end_pos| [piece.pos, end_pos]}
    end
    all_moves.map do |start_pos, end_pos|
      next_board = board.duplicate
      next_board.commit_move(start_pos, end_pos)
      [next_board, [start_pos, end_pos]]
    end
  end

  def piece_value(piece, color)
    mult = piece.color == color ? 1 : -1
    mult * self.class::PIECE_VALUES[piece.class]
  end

  def evaluate(board, color)
    board.grid.flatten.reduce(0) do |acc, piece|
      acc + piece_value(piece, color)
    end
  end
end


if $PROGRAM_NAME == __FILE__
  board = Board.new
  board[[5, 5]] = Queen.new(:black, board, [5, 5])
  computer = ComputerPlayer.new(:white)
  puts computer.get_move(board)
  puts computer.evaluate(board, :white)
end
