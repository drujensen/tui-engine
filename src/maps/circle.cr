require "./base"

module Maps
  class Circle < Base
    property radius : Int32

    def initialize(radius : Int32? = nil, fill : Char = ' ')
      @radius = radius
      side = radius * 2
      super(width: side, height: side)
      (-(radius)..radius).each do |i|
        (-(radius)..radius).each do |j|
          if Math.sqrt(i ** 2 + j ** 2) > radius
            @text[i][j] = fill
          end
        end
      end
    end
  end
end
