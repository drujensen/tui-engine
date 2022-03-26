require "./base"

module Events
  class Bump < Base
    property dir : String
    property x, y : Int32

    def initialize(@dir : String, @x : Int32, @y : Int32)
    end
  end
end
