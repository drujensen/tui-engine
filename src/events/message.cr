require "./base"

module Events
  class Message < Base
    property key : String
    property value : String

    def initialize(@key : String, @value : String)
    end
  end
end
