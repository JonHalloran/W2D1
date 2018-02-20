require_relative "piece"

class Knight < Piece
  MOVE_DIFFS = [[-2, -1],
                [-2, 1],
                [-1, -2],
                [-1, 2],
                [1, -2],
                [1, 2],
                [2, -1],
                [2, 1]].freeze

  include Stepable
  def to_s
    "N"
  end

end
