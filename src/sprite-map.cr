require "./map"

class SpriteMap < Map
  property sprites : Array(Array(Array(Char)))
  property active = Int32

  def initialize(width : Int32? = nil, height : Int32? = nil)
    super(width: width, height: height)
    @sprites = Array(Array(Array(Char))).new
    @sprites << @text
    @active = 0
  end

  def add_sprite(sprite : String) : Int32
    @sprites << sprite.split('\n').map(&.chars)
    pos = @sprites.size - 1
    set_active pos
    return pos
  end

  def set_active(pos : Int32)
    @active = pos
    @text = @sprites[pos]
  end
end
