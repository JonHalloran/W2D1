require_relative "piece"
require_relative "slideable"

class Rook < Piece

  MOVE_DIRS = [:horizontal].freeze

  include Slideable

  def to_s
    "R"
  end

end
