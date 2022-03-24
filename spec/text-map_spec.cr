require "./spec_helper"

describe TextMap do
  it "creates a new Text Map" do
    world = TextMap.new(text: "Hello World!")
    world.height.should eq 1
    world.width.should eq 12
    world.visible.should eq true
  end

  it "displays the text when rendered" do
    text = TextMap.new(text: "Hello World!")
    text.render[0].join.should eq "Hello World!"
  end
end
