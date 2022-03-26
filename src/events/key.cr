require "./base"

module Events
  class Key < Base
    property key : Char

    def initialize(@key : Char)
    end
  end
end
