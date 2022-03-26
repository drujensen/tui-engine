require "./spec_helper"

describe Maps::Circle do
  it "creates a new Circle Map" do
    world = Maps::Circle.new(radius: 5, fill: '+')
    world.height.should eq 10
    world.width.should eq 10
    world.render.each do |row|
      puts row.join
    end
    world.render[1].join.should eq "     +    "
  end
end
