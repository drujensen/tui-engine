require "./textmap"

class GameEngine
  property map : TextMap
  property running : Bool
  property key : Char?

  def initialize(@map : TextMap)
    @running = true
    STDIN.noecho!
    STDIN.raw!
  end

  def input
    @key = STDIN.read_char
  end

  def update
    if key = @key
      @running = @map.update(key)
    end
    @key = nil
  end

  def output
    # clear screen
    puts "\u001B[2J"
    @map.render.each_with_index do |row, i|
      row.each_with_index do |c, j|
        # moves to position i;j
        puts "\u001B[#{i};#{j}H"
        # print the character
        puts "#{c}"
      end
    end
    # hide cursor
    puts "\u001B[?25l"
  end

  def run
    output
    while @running
      input
      update
      output
    end
  end
end
