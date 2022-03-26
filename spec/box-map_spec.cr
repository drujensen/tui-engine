require "./spec_helper"

describe BoxMap do
  it "creates a new Box Map" do
    world = BoxMap.new(width: 10, height: 1, fill: '&')
    world.height.should eq 1
    world.width.should eq 10
    world.render[0].join.should eq "&&&&&&&&&&"
  end
end
