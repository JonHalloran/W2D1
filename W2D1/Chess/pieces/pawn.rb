require_relative "piece"
require "byebug"

class Pawn < Piece
  attr_reader :direction

  def initialize(*args)
    super(*args)
    @direction = self.color == :white ? -1 : 1
  end

  def to_s
    "P"
  end

  def moves
    move_forward + attack
  end

  private

  def at_start_row?
    home_row = self.board.class::HOME_ROW[self.color]
    pawn_home_row = home_row + self.direction
    self.pos[0] == pawn_home_row
  end

  def move_forward
    result = []
    new_pos = [self.pos[0] + direction, self.pos[1]]
    result << new_pos if self.board.empty?(new_pos)
    if at_start_row? && !result.empty?
      new_pos = [self.pos[0] + 2 * direction, self.pos[1]]
      result << new_pos if self.board.empty?(new_pos)
    end
    result
  end

  def attack
    [-1, 1].map do |c_diff|
      [self.pos[0] + self.direction, self.pos[1] + c_diff]
    end.select { |pos| enemy?(self.board[pos]) }
  end

end
