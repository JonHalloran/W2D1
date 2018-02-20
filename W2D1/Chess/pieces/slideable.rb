module Slideable
  HORIZONTAL_DIRS = [[0, 1], [1, 0], [-1, 0], [0, -1]].freeze
  DIAGONAL_DIRS = [[1, 1], [-1, 1], [1, -1], [-1, -1]].freeze

  def moves
    result = []
    if self.class::MOVE_DIRS.include?(:horizontal)
      HORIZONTAL_DIRS.each do |dr, dc|
        result += grow_unblocked_moves_in_dir(dr, dc)
      end
    end
    if self.class::MOVE_DIRS.include?(:diagonal)
      DIAGONAL_DIRS.each do |dr, dc|
        result += grow_unblocked_moves_in_dir(dr, dc)
      end
    end
    result
  end

  def grow_unblocked_moves_in_dir(dr, dc)
    result = []
    row, col = self.pos
    row += dr
    col += dc
    while self.board.empty?([row, col])
      result << [row, col]
      row += dr
      col += dc
    end
    return result unless self.board.valid_pos?([row, col])
    return result unless enemy?(self.board[[row, col]])
    result << [row, col]
  end
end
