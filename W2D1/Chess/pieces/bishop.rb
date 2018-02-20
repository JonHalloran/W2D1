require_relative "piece"
require_relative "slideable"

class Bishop < Piece

  MOVE_DIRS = [:diagonal].freeze

  include Slideable

  def to_s
    "B"
  end

end
