require "./spec_helper"

describe SpriteMap do
  it "creates a new Sprite Map" do
    map = SpriteMap.new(width: 10, height: 10)
    map.width.should eq 10
    map.height.should eq 10
    map.sprites.size.should eq 1
  end

  it "supports adding a sprite" do
    map = SpriteMap.new(width: 9, height: 4)
    map.add_sprite <<-SPRITE
    +-------+
    | o   o |
    |  www  |
    +-------+
    SPRITE
    map.sprites.size.should eq 2
    map.active.should eq 1
    map.render[0].join.should eq "+-------+"
  end

  it "supports swapping sprites" do
    map = SpriteMap.new(width: 9, height: 4)
    map.add_sprite <<-SPRITE
    +-------+
    | o   o |
    |  www  |
    +-------+
    SPRITE
    map.set_active(0)
    map.render[0].join.should eq "         "
  end
end
