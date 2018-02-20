require_relative "piece"
require_relative "slideable"

class Queen < Piece
  MOVE_DIRS = %i(horizontal diagonal).freeze

  include Slideable

  def to_s
    "Q"
  end

end
