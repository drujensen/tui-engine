require "./map"

class FrameMap < Map
  def initialize(width : Int32? = nil, height : Int32? = nil)
    super(width: width, height: height)
    corner = '+'
    vertical = '|'
    horizontal = '-'

    @text[0][0] = corner
    (1..@width - 2).each { |i| @text[0][i] = horizontal }
    @text[0][@width - 1] = corner

    (1..@height - 2).each { |j| @text[j][0] = vertical }
    (1..@height - 2).each { |j| @text[j][@width - 1] = vertical }

    @text[@height - 1][0] = corner
    (1..@width - 2).each { |i| @text[@height - 1][i] = horizontal }
    @text[@height - 1][@width - 1] = corner
  end
end
