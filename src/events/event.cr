require "./*"

module Events
  class EventHandler
    property type : String
    property priority : Int32
    property method : Proc(Base, Bool)

    def initialize(@type : String, @priority : Int32, @method : Proc(Base, Bool))
    end
  end

  class Event
    @@handlers : Array(EventHandler) = Array(EventHandler).new

    def self.register(type : String, priority : Int32, &method : Events::Base -> Bool)
      handler = EventHandler.new(type, priority, method)
      @@handlers << handler
      return handler
    end

    def self.deregister(handler : EventHandler)
      @@handlers.delete(handler)
    end

    def self.key_event(key : Char)
      @@handlers.select { |h| h.type == "key" }.sort(&.priority).each do |handler|
        break if handler.method.call(Key.new(key))
      end
    end

    def self.bump_event(dir : String, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "bump" }.sort(&.priority).each do |handler|
        break if handler.method.call(Bump.new(dir, x, y))
      end
    end

    def self.action_event(sibling : Maps::Base, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "action" }.sort(&.priority).each do |handler|
        break if handler.method.call(Action.new(sibling, x, y))
      end
    end

    def self.tick_event
      @@handlers.select { |h| h.type == "tick" }.sort(&.priority).each do |handler|
        break if handler.method.call(Tick.new)
      end
    end
  end
end
