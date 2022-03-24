class TextMap
  property visible : Bool = true
  property height : Int8
  property width : Int8
  property text : Array(Array(Char))
  property dirty : Bool

  # current position in parent map
  property parent : TextMap?
  property children : Array(TextMap)
  property x : Int8 = 0
  property y : Int8 = 0
  property z : Int8 = 0

  def initialize(height : Int32? = nil, width : Int32? = nil, @fill : Char = ' ')
    if w = width
      @width = w.to_i8
    else
      @width = `tput cols`.to_i8 - 2
    end

    if h = height
      @height = h.to_i8
    else
      @height = `tput lines`.to_i8 - 2
    end

    @dirty = true
    @children = [] of TextMap
    @text = Array(Array(Char)).new
    (0...@height).each do
      @text << Array.new(@width, @fill)
    end
  end

  def add(@parent : TextMap, x : Int32? = nil, y : Int32? = nil, @z : Int8 = 1)
    if new_x = x
      @x = x.to_i8
    else
      @x = ((parent.width - @width) / 2).to_i8
    end

    if new_y = y
      @y = y.to_i8
    else
      @y = ((parent.height - @height) / 2).to_i8
    end

    if parent = @parent
      parent.children << self
    end
    @dirty = true
  end

  def set(@x : Int8, @y : Int8)
    @dirty = true
  end

  def set(@x : Int8, @y : Int8, @z : Int8)
    @dirty = true
  end

  def move(x : Int8, y : Int8)
    @x = @x + x
    @y = @y + y
    @dirty = true
  end

  def remove
    if parent = @parent
      parent.children.reject! self
    end
    @parent = nil
  end

  def hide
    @visible = false
  end

  def show
    @visible = true
  end

  def update(key : Char) : Bool
    result = handle_key(key)
    children.each do |child|
      result = false unless child.update(key)
    end
    return result
  end

  def render : Array(Array(Char))
    screen = Array(Array(Char)).new
    (0...@height).each do |row|
      screen << Array(Char).new(@width, @fill)
    end

    render(screen)
  end

  def render(screen : Array(Array(Char))) : Array(Array(Char))
    @dirty = false

    return screen if obs
    return screen if collision

    # render at x,y position
    (y...(y + @height)).each_with_index do |row, i|
      (x...(x + @width)).each_with_index do |col, j|
        screen[row][col] = @text[i][j]
      end
    end

    @children.sort_by(&.z).each do |child|
      screen = child.render(screen) if child.visible
    end
    return screen
  end

  def is_dirty?
    result = false
    result = true if @dirty
    @children.each do |child|
      result = true if child.is_dirty?
    end
    return result
  end

  def obs
    if parent = @parent
      if x < 0
        bump("left", x, y)
        return true
      elsif x + @width > parent.width
        bump("right", x + @width, y + @height)
        return true
      elsif y < 0
        bump("top", x, y)
        return true
      elsif y + @height > parent.height
        bump("bottom", x + width, y + @height)
        return true
      end
    end
    return false
  end

  def collision
    if parent = @parent
      siblings = parent.children.reject(self).select { |child| child.z == @z }
      siblings.each do |sibling|
        result = true
        l1 = @x
        r1 = @x + @width
        l2 = sibling.x
        r2 = sibling.x + sibling.width
        t1 = @y
        b1 = @y + @height
        t2 = sibling.y
        b2 = sibling.y + sibling.height

        # If one rectangle is on left side of other
        if l1 >= r2 || l2 >= r1
          result = false
        end
        # If one rectangle is above other
        if t1 >= b2 || t2 >= b1
          result = false
        end

        if result
          action(sibling, @x, @y)
          return true
        end
      end
    end
    return false
  end

  def bump(dir : String, x : Int8, y : Int8)
  end

  def action(sibling : TextMap, x : Int8, y : Int8)
  end

  def handle_key(key : Char) : Bool
    return true
  end
end
