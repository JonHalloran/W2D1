require "io/console"
require_relative "board"
require "byebug"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :cursor_pos, :selected_position

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected_position = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def handle_key(key)
    if %i(return space).include?(key)
      self.select_position
    elsif MOVES.keys.include?(key)
      update_pos(MOVES[key])
    elsif key == :ctrl_c
      Process.exit(0)
    end
  end

  def update_pos(diff)
    new_pos = [cursor_pos[0] + diff[0],
               cursor_pos[1] + diff[1]]
    self.cursor_pos = new_pos if board.valid_pos?(new_pos)
    nil
  end

  def select_position
    if self.selected_position.nil?
      unless board[self.cursor_pos].is_a?(NullPiece)
        # TODO: check color
        self.selected_position = self.cursor_pos
      end
    else
      board.move_piece(self.selected_position, self.cursor_pos)
      self.selected_position = nil
    end
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

end
