require "./events/*"
require "./maps/*"

class TuiEngine
  property map : Maps::Base
  property running : Bool
  property key : Char?
  property visible : Bool = true

  def initialize(@map : Maps::Base)
    @running = true
    STDIN.noecho!
    STDIN.raw!
    STDIN.read_timeout = 0
    # hide cursor
    puts "\u001B[?25l"
  end

  def input
    begin
      @key = STDIN.read_char
    rescue
    end
    if key = @key
      Events::Event.key_event(key)
    end
    @key = nil
  end

  def output
    return unless @map.is_dirty?

    # clear screen
    puts "\u001B[2J"
    @map.render.each_with_index do |row, i|
      row.each_with_index do |c, j|
        # moves to position i;j
        puts "\u001B[#{i + 1};#{j + 1}H"

        # TODO: print the color

        # print the character
        puts "#{c}"

        # TODO: reset
      end
    end
  end

  def run
    @running = true
    output

    while @running
      elapsed_time = Time.measure do
        input
        Events::Event.tick_event
        output
      end
      # 30 fps
      sleep(33.milliseconds - elapsed_time / 1000)
    end

    # show cursor
    puts "\u001B[?25h"
    STDIN.cooked!
  end

  def stop
    @running = false
  end

  def on_message(&block : String, String -> Nil) : Events::EventHandler
    return Events::Event.register(self, "message") do |event|
      message_event = event.as(Events::Message)
      block.call(message_event.key, message_event.value)
    end
  end

  def off(event : Events::EventHandler)
    Events::Event.deregister(event)
  end
end
