require "./base"

module Events
  class Action < Base
    property sibling : Maps::Base

    def initialize(@sibling : Maps::Base)
    end
  end
end
