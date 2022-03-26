require "./spec_helper"

describe CircleMap do
  it "creates a new Circle Map" do
    world = CircleMap.new(radius: 5, fill: '+')
    world.height.should eq 10
    world.width.should eq 10
    world.render.each do |row|
      puts row.join
    end
    world.render[1].join.should eq "     +    "
  end
end
