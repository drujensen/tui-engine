module Maps
  class Base
    property visible : Bool = true
    property height : Int32
    property width : Int32
    property text : Array(Array(Char))
    property dirty : Bool
    property fill : Char

    # current position in parent map
    property parent : Base?
    property children : Array(Base)
    property x : Int32 = 0
    property y : Int32 = 0
    property z : Int32 = 0

    def initialize(height : Int32? = nil, width : Int32? = nil, fill : Char? = nil)
      if w = width
        @width = w
      else
        @width = `tput cols`.to_i - 2
      end

      if h = height
        @height = h
      else
        @height = `tput lines`.to_i - 2
      end

      if f = fill
        @fill = f
      else
        @fill = ' '
      end

      @dirty = true
      @children = [] of Base
      @text = Array(Array(Char)).new
      (0...@height).each do
        @text << Array.new(@width, @fill)
      end
    end

    def add(@parent : Base, x : Int32? = nil, y : Int32? = nil, @z : Int32 = 1)
      if new_x = x
        @x = new_x
      else
        @x = ((parent.width - @width) / 2).to_i
      end

      if new_y = y
        @y = new_y
      else
        @y = ((parent.height - @height) / 2).to_i
      end

      if parent = @parent
        parent.children << self
      end
      @dirty = true
    end

    def set(@x : Int32, @y : Int32)
      @dirty = true
    end

    def set(@x : Int32, @y : Int32, @z : Int32)
      @dirty = true
    end

    def move(x : Int32, y : Int32)
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

    def render : Array(Array(Char))
      screen = Array(Array(Char)).new
      (0...@height).each do |row|
        screen << Array(Char).new(@width, @fill)
      end

      render(screen)
    end

    def render(screen : Array(Array(Char))) : Array(Array(Char))
      @dirty = false

      return screen unless @visible
      return screen if trigger_bumps
      trigger_actions

      parent_x = @x
      parent_y = @y
      if parent = @parent
        parent_x = parent.x + @x
        parent_y = parent.y + @y
      end

      # render at x,y position
      (parent_y...(parent_y + @height)).each_with_index do |row, i|
        (parent_x...(parent_x + @width)).each_with_index do |col, j|
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

    def trigger_bumps
      if parent = @parent
        if x < 0
          Events::Event.bump_event(self, "left", x, y)
          return true
        elsif x + @width > parent.width
          Events::Event.bump_event(self, "right", x + @width, y + @height)
          return true
        elsif y < 0
          Events::Event.bump_event(self, "top", x, y)
          return true
        elsif y + @height > parent.height
          Events::Event.bump_event(self, "bottom", x + width, y + @height)
          return true
        end
      end
      return false
    end

    def trigger_actions
      if parent = @parent
        siblings = parent.children.reject(self).select { |child| child.z == @z }
        l1 = @x
        r1 = @x + @width
        t1 = @y
        b1 = @y + @height
        siblings.each do |sibling|
          result = true
          l2 = sibling.x
          r2 = sibling.x + sibling.width
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
            Events::Event.action_event(self, sibling, @x, @y)
            return true
          end
        end
      end
      return false
    end

    def on_tick(&block) : Events::EventHandler
      return Events::Event.register(self, "tick") do
        block.call
      end
    end

    def on_key(&block : Char -> Nil) : Events::EventHandler
      return Events::Event.register(self, "key") do |event|
        key_event = event.as(Events::Key)
        block.call(key_event.key)
      end
    end

    def on_message(&block : String, String -> Nil) : Events::EventHandler
      return Events::Event.register(self, "message") do |event|
        message_event = event.as(Events::Message)
        block.call(message_event.key, message_event.value)
      end
    end

    def on_bump(&block : String, Int32, Int32 -> Nil) : Events::EventHandler
      return Events::Event.register(self, "bump") do |event|
        bump_event = event.as(Events::Bump)
        block.call(bump_event.dir, bump_event.x, bump_event.y)
      end
    end

    def on_action(&block : Maps::Base, Int32, Int32 -> Nil) : Events::EventHandler
      return Events::Event.register(self, "action") do |event|
        action_event = event.as(Events::Action)
        block.call(action_event.sibling, action_event.x, action_event.y)
      end
    end

    def off(event : Events::EventHandler)
      Events::Event.deregister(event)
    end

    def send(key : String, value : String)
      Events::Event.message_event(key: key, value: value)
    end
  end
end
