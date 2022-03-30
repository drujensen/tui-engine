require "./base"

module Maps
  class Scrolling < Base
    property speed : Int32
    property pos : Int32 = 0
    property chars : Array(Array(Char))

    def initialize(text : String, speed : Int32? = 30)
      super(width: text.size, height: 1)
      @speed = speed
      @chars = text.split('\n').chars
      @height = @chars.size
      @text = Array(Array(Char)).new(@height)
      (0...@height).each do
        @text << Array(Char).new(max_width, ' ')
      end
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
  end
end
