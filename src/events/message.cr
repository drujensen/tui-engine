require "./base"

module Events
  class Message < Base
    property message : String

    def initialize(@message : String)
    end
  end
end
