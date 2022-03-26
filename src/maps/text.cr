require "./base"

module Maps
  class Text < Base
    def initialize(text : String)
      super(width: text.size, height: 1)

      @text = Array(Array(Char)).new
      @text << text.chars
    end
  end
end
