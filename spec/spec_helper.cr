require "spec"
require "../src/*"

class World < TextMap
  def bump(dir : String, x : Int8, y : Int8)
    puts "bumped into the #{dir} wall"
  end

  def action(sibling : TextMap, x : Int8, y : Int8)
    puts "hit #{sibling}"
  end

  def handle_key(key : Char) : Bool
    if key == 'q'
      return false
    end
    return true
  end
end

class Group < TextMap
  def bump(dir : String, x : Int8, y : Int8)
    puts "bumped into the #{dir} wall"
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
