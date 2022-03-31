require "./base"

module Maps
  class Scrolling < Base
    property speed : Int32
    property chars : Array(Char)

    def initialize(text : String, speed : Int32? = 30)
      super(width: text.size, height: 1)
      @speed = speed
      @chars = text.chars
    end

    def animate
      @text = Array(Array(Char)).new
      @text << Array(Char).new(@chars.size, ' ')

      count = 0
      pos = 0
      tick_event = on_tick do
        count = count + 1
        if count > (30 / speed).to_i
          if pos < @chars.size
            @text[0][pos] = @chars[pos]
          end
          pos = pos + 1
          count = 0
        end
      end

      key_event = on_key do |key|
        if key == ' '
          if pos < @chars.size
            @text[0] = @chars
            pos = @chars.size
          else
            @text[0] = Array(Char).new(@chars.size, ' ')
          end
        end
      end

      if pos >= @chars.size
        off(tick_event)
      end
    end
  end
end
