require "./sprite"

class Maps::Input < Maps::Sprite
  property key_event : Events::EventHandler?
  property key : String
  property title : String
  property question : String
  property result : String

  def initialize(@key : String, @title : String, @question : String)
    width = [@title.size, @question.size].max
    super(sprite: <<-SPRITE
    ┌─#{@title}#{"─" * (width - @title.size)}─┐
    │ #{@question}#{" " * (width - @question.size)} │
    │ #{" " * width} │
    │ █#{" " * (width - 1)} │
    └─#{"─" * width}─┘
    SPRITE
    )

    @result = ""
    @key_event = on_key do |key|
      handle_key(key) if visible
    end
  end

  def handle_key(key : Char)
    if key == '\u007F'
      @result = @result.rchop
      @text[3][2 + @result.size] = ' '
      @text[3][3 + @result.size] = ' '
    elsif key == '\r'
      hide
      if event = @key_event
        off(event)
      end
      Events::Event.message_event(key: @key, value: @result)
    else
      @result = @result + key
    end

    @result.chars.each_with_index do |char, i|
      @text[3][2 + i] = char
    end
    @text[3][2 + @result.size] = '█'

    @dirty = true
  end
end
