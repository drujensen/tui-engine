require "./base"

module Maps
  class Text < Base
    property speed : Int32
    property pos : Int32 = 0
    property chars : Array(Char)

    def initialize(text : String, speed : Int32? = 0)
      super(width: text.size, height: 1)
      @speed = speed
      @chars = text.chars
      @text = Array(Array(Char)).new
      if @speed == 0
        @text << @chars
        return
      end

      @text << Array(Char).new(@chars.size, ' ')
      @count = 0
      event = Events::Event.register("tick") do
        if visible
          @count = @count + 1
          if @count > (30 / speed).to_i
            if @pos < @chars.size
              @text[0][@pos] = @chars[@pos]
            end
            @pos = @pos + 1
            @count = 0
          end
        end
      end
      if @pos >= @chars.size
        Events::Event.deregister(event)
      end
    end

    def update(text : String)
      @width = text.size
      @text[0] = text.chars
    end
  end
end
