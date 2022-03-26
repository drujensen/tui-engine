require "./base"

module Events
  class Action < Base
    property sibling : Maps::Base
    property x, y : Int32

    def initialize(@sibling : Maps::Base, @x : Int32, @y : Int32)
    end
  end
end
