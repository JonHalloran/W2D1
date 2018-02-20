require_relative "piece"
require_relative "stepable"

class King < Piece
  MOVE_DIFFS = [[-1, -1],
                [-1, 0],
                [-1, 1],
                [0, -1],
                [0, 1],
                [1, -1],
                [1, 0],
                [1, 1]].freeze

  include Stepable

  def to_s
    "K"
  end

end
