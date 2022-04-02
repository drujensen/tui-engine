require "./*"

module Events
  class EventHandler
    property type : String
    property me : (Maps::Base | TuiEngine)
    property method : Proc(Base, Nil)

    def initialize(@me : (Maps::Base | TuiEngine), @type : String, @method : Proc(Base, Nil))
    end
  end

  class Event
    @@handlers : Array(EventHandler) = Array(EventHandler).new

    def self.register(me : (Maps::Base | TuiEngine), type : String, &method : Events::Base -> Nil)
      handler = EventHandler.new(me, type, method)
      @@handlers << handler
      return handler
    end

    def self.deregister(handler : EventHandler)
      @@handlers.delete(handler)
    end

    def self.tick_event
      @@handlers.select { |h| h.type == "tick" }.each do |handler|
        handler.method.call(Tick.new)
      end
    end

    def self.key_event(key : Char)
      @@handlers.select { |h| h.type == "key" }.each do |handler|
        handler.method.call(Key.new(key))
      end
    end

    def self.message_event(key : String, value : String)
      @@handlers.select { |h| h.type == "message" }.each do |handler|
        handler.method.call(Message.new(key, value))
      end
    end

    def self.bump_event(me : Maps::Base, dir : String, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "bump" && h.me == me }.each do |handler|
        handler.method.call(Bump.new(dir, x, y))
      end
    end

    def self.action_event(me : Maps::Base, sibling : Maps::Base, x : Int32, y : Int32)
      @@handlers.select { |h| h.type == "action" && h.me == me }.each do |handler|
        handler.method.call(Action.new(sibling, x, y))
      end
    end
  end
end
