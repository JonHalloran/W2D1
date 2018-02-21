require_relative "piece"
require "singleton"

class NullPiece < Piece

  include Singleton

  def initialize
    @color = :null
  end

  def make_copy(_)
    self
  end

  def moves
    []
  end
end
