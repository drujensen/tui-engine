require "./base"

module Maps
  class Box < Base
    def initialize(width : Int32? = nil, height : Int32? = nil, fill : Char = ' ')
      super(width: width, height: height, fill: fill)
    end
  end
end
