require "./textmap"

class GameEngine
  property map : TextMap
  property running : Bool
  property key : Char?

  def initialize(@map : TextMap)
    @running = true
    STDIN.noecho!
  end

  def input
    @key = STDIN.read_char
  end

  def update
    if @key == 'q'
      @running = false
    end
    if @key == 'a'
      @map.children[0].move(-1, 0)
    end
    if @key == 'd'
      @map.children[0].move(+1, 0)
    end
    if @key == 'w'
      @map.children[0].move(0, -1)
    end
    if @key == 's'
      @map.children[0].move(0, +1)
    end
  end

  def output
    # `tput clear`
    puts "\033[2J\033[1;1H"
    @map.render.each do |row|
      puts row.join
    end
  end

  def run
    while @running
      elapsed_time = Time.measure do
        input
        update
        output
      end
      sleep((33.milliseconds - elapsed_time) / 1000) # 30fps
    end
  end
end
