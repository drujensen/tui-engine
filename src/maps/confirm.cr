require "./sprite"

class Maps::Confirm < Maps::Sprite
  property key_event : Events::EventHandler?
  property key : String
  property title : String
  property question : String

  def initialize(@key : String, @title : String, @question : String)
    width = [@title.size, @question.size].max
    super(sprite: <<-SPRITE
    ┌─#{@title}#{"─" * (width - @title.size)}─┐
    │ #{@question}#{" " * (width - @question.size)} │
    │ #{" " * width} │
    │ [Y]es#{" " * (width - 9)}[N]o │
    └─#{"─" * width}─┘
    SPRITE
    )

    @result = ""
    @key_event = on_key do |key|
      handle_key(key) if visible
    end
    @dirty = true
  end

  def handle_key(key : Char)
    if key == 'y' || key == 'Y'
      @result = "yes"
    elsif key == '\r'
      @result = "yes"
    elsif key == 'n' || key == 'N'
      @result = "no"
    elsif key == '\e'
      @result = "no"
    else
      return
    end

    hide
    if event = @key_event
      off(event)
    end

    send(key: @key, value: @result)
  end
end
