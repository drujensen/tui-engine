require "spec"
require "../src/*"

class World < TextMap
  def handle_key(key : Char) : Bool
    if key == 'q'
      return false
    end
    return true
  end
end

class Group < TextMap
  def bump(dir : String, x : Int8, y : Int8)
    if dir == "top"
      move(0, +1)
    end

    if dir == "bottom"
      move(0, -1)
    end

    if dir == "left"
      move(+1, 0)
    end

    if dir == "right"
      move(-1, 0)
    end
  end

  def action(sibling : TextMap, x : Int8, y : Int8)
    puts "hit #{sibling}"
  end

  def handle_key(key : Char) : Bool
    if key == 'a'
      move(-1, 0)
    end

    if key == 'd'
      move(+1, 0)
    end

    if key == 's'
      move(0, +1)
    end

    if key == 'w'
      move(0, -1)
    end

    return true
  end
end
