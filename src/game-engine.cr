require "./*"

class GameEngine
  property map : Map
  property running : Bool
  property key : Char?

  def initialize(@map : Map)
    @running = true
    STDIN.noecho!
    STDIN.raw!
    STDIN.read_timeout = 0
    # hide cursor
    puts "\u001B[?25l"
  end

  def input
    begin
      @key = STDIN.read_char
    rescue
    end
  end

  def update
    if key = @key
      @running = @map.update(key)
    end
    @key = nil
  end

  def output
    return unless @map.is_dirty?
    # clear screen
    puts "\u001B[2J"
    @map.render.each_with_index do |row, i|
      row.each_with_index do |c, j|
        # moves to position i;j
        puts "\u001B[#{i + 1};#{j + 1}H"
        # print the character
        puts "#{c}"
      end
    end
  end

  def run
    output
    while @running
      input
      update
      output
    end
    # show cursor
    puts "\u001B[?25h"
    STDIN.cooked!
  end
end
