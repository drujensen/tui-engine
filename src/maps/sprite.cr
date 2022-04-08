require "./base"

module Maps
  class Sprite < Base
    property sprites : Array(Array(Array(Char)))
    property active : Int32 = 0

    def initialize(sprite : String)
      chars = sprite.split('\n').map(&.chars)
      width = chars.max_by(&.size).size
      height = chars.size
      super(width: width, height: height)
      @sprites = Array(Array(Array(Char))).new
      @sprites << chars
      set_active 0
    end

    def add_sprite(sprite : String) : Int32
      chars = sprite.split('\n').map(&.chars)
      @width = [@width, chars.max_by(&.size).size].max
      @height = [@height, chars.size].max
      @sprites << chars
      pos = @sprites.size - 1
      return pos
    end

    def set_active(pos : Int32)
      @active = pos
      @text = @sprites[pos]
    end
  end
end
