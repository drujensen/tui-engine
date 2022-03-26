require "./base"

module Maps
  class Frame < Base
    def initialize(width : Int32? = nil, height : Int32? = nil)
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
    end
  end
end
