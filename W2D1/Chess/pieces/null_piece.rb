require_relative "piece"
require "singleton"

class NullPiece < Piece

  include Singleton

  def initialize
    @color = :null
  end

  def moves
    []
  end
end
