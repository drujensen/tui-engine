require "./*"

module Events
  class EventHandler
    property type : String
    property method : Proc(Base, Nil)

    def initialize(@type : String, @method : Proc(Base, Nil))
    end
  end

  class Event
    @@handlers : Array(EventHandler) = Array(EventHandler).new

    def self.register(type : String, &method : Events::Base -> Nil)
      handler = EventHandler.new(type, method)
      @@handlers << handler
      return handler
    end

    def self.deregister(handler : EventHandler)
      @@handlers.delete(handler)
    end

    def self.message_event(message : String)
      @@handlers.select { |h| h.type == "message" }.each do |handler|
        handler.method.call(Message.new(message))
      end
    end

    def self.key_event(key : Char)
      @@handlers.select { |h| h.type == "key" }.each do |handler|
        handler.method.call(Key.new(key))
      end
    end

    def self.bump_event(dir : String, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "bump" }.each do |handler|
        handler.method.call(Bump.new(dir, x, y))
      end
    end

    def self.action_event(sibling : Maps::Base, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "action" }.each do |handler|
        handler.method.call(Action.new(sibling, x, y))
      end
    end

    def self.tick_event
      @@handlers.select { |h| h.type == "tick" }.each do |handler|
        handler.method.call(Tick.new)
      end
    end
  end
end
