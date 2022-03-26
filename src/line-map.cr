require "./map"

class LineMap < Map
  def initialize(width : Int32? = nil, height : Int32? = nil, inverted : Bool? = false, fill : Char = ' ')
    super(width: width, height: height)
    if inverted
      slope = (width / height)
      (0...height).each do |y|
        (0...width).each do |x|
          if (x / y) == slope || width == 1 || height == 1
            @text[height - y][x] = fill
          end
        end
      end
    else
      slope = (height / width)
      (0...height).each do |y|
        (0...width).each do |x|
          if (y / x) == slope || width == 1 || height == 1
            @text[y][x] = fill
          end
        end
      end
    end
  end
end
