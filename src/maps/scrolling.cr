require "./base"

module Maps
  class Scrolling < Base
    property speed : Int32
    property chars : Array(Array(Char))
    property active : Int32 = 0

    def initialize(text : String, speed : Int32? = 30)
      @speed = speed
      max_width = 0
      @chars = Array(Array(Char)).new
      text.each_line do |line|
        @chars << line.chars
        max_width = line.chars.size if line.chars.size > max_width
      end
      super(width: max_width, height: 1)
    end

    def animate
      @text[0] = Array(Char).new(width, ' ')
      active = 0
      count = 0
      pos = 0

      tick_event = on_tick do
        if active < @chars.size && pos < @chars[active].size
          count = count + 1
          if count > (30 / speed).to_i
            @text[0][pos] = @chars[active][pos]
            pos = pos + 1
            count = 0
          end
        end
      end

      key_event = on_key do |key|
        if key == ' '
          if active < @chars.size && pos < @chars[active].size
            @chars[active].each_with_index do |char, i|
              @text[0][i] = char
            end
            pos = @chars[active].size
          else
            if active < @chars.size
              @text[0] = Array(Char).new(width, ' ')
              active = active + 1
              count = 0
              pos = 0
            end
          end
        end
      end

      if active >= @chars.size
        off(key_event)
        off(tick_event)
      end
    end
  end
end
