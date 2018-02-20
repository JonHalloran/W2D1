require "byebug"

module Stepable
  def moves
    row, col = self.pos
    self.class::MOVE_DIFFS.map do |d_row, d_col|
      [row + d_row, col + d_col]
    end.select do |pos|
      self.board.valid_pos?(pos) && !ally?(self.board[pos])
    end
  end

end
