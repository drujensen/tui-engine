require "./spec_helper"

describe GameEngine do
  it "initializes with map" do
    cols = `tput cols`.to_i8
    world = World.new(height: 25, width: cols, fill: '-')
    group = Group.new(height: 10, width: 10, fill: '^')
    group.add(world, 10, 10)
    game = GameEngine.new(world)
    game.run
  end
end
