require "./spec_helper"

describe TuiEngine do
  it "initializes with map" do
    world = World.new
    group = Group.new(height: 10, width: 10, fill: '^')
    group.add(world)
    game = MyGame.new(world)
    game.run
  end
end
