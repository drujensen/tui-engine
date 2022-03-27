require "./base"

module Maps
  class Frame < Base
    def initialize(title : String = "", width : Int32? = nil, height : Int32? = nil)
      super(width: width, height: height)

      corner = '+'
      vertical = '|'
      horizontal = '-'

      [0, @height - 1].each do |row|
        @text[row][0] = corner
        (1..@width - 2).each { |i| @text[row][i] = horizontal }
        @text[row][@width - 1] = corner
      end

      [0, @width - 1].each do |col|
        (1..@height - 2).each { |j| @text[j][col] = vertical }
      end

      title = Maps::Text.new(title)
      title.add(self, x: 2, y: 0, z: self.z)
    end

    def obs
      if parent = @parent
        if @x < 1
          Events::Event.message_event(key: "cmd", value: "quit")
          Events::Event.bump_event("left", @x, @y)
          return true
        elsif @x + @width > parent.width - 1
          Events::Event.bump_event("right", @x + @width, @y + @height)
          return true
        elsif @y < 1
          Events::Event.bump_event("top", @x, @y)
          return true
        elsif @y + @height > parent.height - 1
          Events::Event.bump_event("bottom", @x + @width, @y + @height)
          return true
        end
      end
      return false
    end
  end
end
