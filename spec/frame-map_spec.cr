require "./spec_helper"

describe FrameMap do
  it "creates a new Frame Map" do
    world = FrameMap.new(width: 10, height: 10)
    world.height.should eq 10
    world.width.should eq 10
    world.visible.should eq true
  end

  it "displays the frame when rendered" do
    frame = FrameMap.new(width: 10, height: 3)
    display = frame.render
    display[0].join.should eq "+--------+"
    display[1].join.should eq "|        |"
    display[2].join.should eq "+--------+"
  end
end
