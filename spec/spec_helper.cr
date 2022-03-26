require "spec"
require "../src/**"

class MyGame < TuiEngine
  def initialize(map : Maps::Base)
    super(map)
    Events::Event.register("key") do |event|
      if event.as(Events::Key).key == 'q'
        stop
      end
    end
  end
end

class World < Maps::Frame
end

class Group < Maps::Base
  def initialize(height : Int32, width : Int32, fill : Char)
    super(height: height, width: width, fill: fill)
    Events::Event.register("key") do |event|
      key = event.as(Events::Key)
      handle_key(key.key)
    end
    Events::Event.register("bump") do |event|
      bump = event.as(Events::Bump)
      handle_bump(bump.dir, bump.x, bump.y)
    end
    Events::Event.register("action") do |event|
      action = event.as(Events::Action)
      handle_action(action.sibling, action.x, action.y)
    end
  end

  def handle_key(key : Char)
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
  end

  def handle_bump(dir : String, x : Int32, y : Int32)
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

  def handle_action(sibling : Maps::Base, x : Int32, y : Int32)
    puts "hit #{sibling}"
  end
end
